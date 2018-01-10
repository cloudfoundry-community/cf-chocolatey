<#
.Synopsis
    Builds the CF CLI Chocolatey package
.Description
    Using the version specified, this script will create a Choco package ready
    to publish to Chocolate.org. This script will automatically push the
    build artifacts.
#>

$buildDir = $pwd.Path
$tplDir = Join-Path -Path $buildDir -ChildPath 'template'

# Get the latest GH release and choco version
$chocoVersion = ((choco info cloudfoundry-cli -r) -split '\|')[1]
$version = (Invoke-WebRequest -UseBasicParsing 'https://api.github.com/repos/cloudfoundry/cli/releases/latest' |`
  ConvertFrom-Json | Select-Object -ExpandProperty tag_name).Replace('v', '')

Write-Output "Chocolatey CF CLI version: $chocoVersion"
Write-Output "GitHub Releases CF CLI version: $version"

# Write out nuspec file, force UTF-8 without BOM
$nuspecContent = (Get-Content -Encoding utf8 -Raw "$tplDir\cloudfoundry-cli.nuspec.tpl").
  Replace('${version}', $version)

$utf8NoBom = New-Object System.Text.UTF8Encoding
[System.IO.File]::WriteAllText("$buildDir\cloudfoundry-cli.nuspec", $nuspecContent, $utf8NoBom)

# Write out the install PS script
$toolsDir = Join-Path -Path $buildDir -ChildPath 'tools'
New-Item -Path $toolsDir -ItemType Directory -Force | Out-Null
(Get-Content -Encoding utf8 -Raw "$tplDir\chocolateyinstall.ps1.tpl").
  Replace('${version}', $version) | `
  Set-Content "$toolsDir\chocolateyinstall.ps1" -Encoding utf8

if (-not (Test-Path env:ChocolateyInstall)) {
  Write-Error "Env var ChocolateyInstall doesn't exist. Is Chocolatey installed?"
}

$chocoBinDir = Join-Path -Path $env:ChocolateyInstall -ChildPath 'bin'
Invoke-Expression "$chocoBinDir\cpack.exe $buildDir\cloudfoundry-cli.nuspec"

# Only publish the choco package if it's out of date
if ([System.Version]$version -gt [System.Version]$chocoVersion) {
  Write-Output 'Publishing CF CLI to Chocolatey...'
  choco push $buildDir\cloudfoundry-cli.$version.nupkg
} else {
  Write-Output 'The latest CF CLI version is already available on Chocolatey, skipping publish'
}
