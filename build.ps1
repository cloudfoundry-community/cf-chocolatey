<#
.Synopsis
    Builds the CF CLI Chocolatey package
.Description
    Using the version specified, this script will create a Choco package ready
    to publish to Chocolate.org. This script will _not_ automatically push the
    build artifacts.
#>

param (
    [Parameter(Mandatory=$true)][string]$version
)

$buildDir = $pwd.Path
$tplDir = Join-Path -Path $buildDir -ChildPath 'template'

# Write out nuspec file, force UTF-8 without BOM
$nuspecContent = (Get-Content -Encoding utf8 -Raw "$tplDir\cloudfoundry-cli.nuspec.tpl").
  Replace('${version}', $version)

$utf8NoBom = New-Object System.Text.UTF8Encoding
[System.IO.File]::WriteAllText("$buildDir\cloudfoundry-cli.nuspec", $nuspecContent, $utf8NoBom)

# Write out the install PS script
$toolsDir = Join-Path -Path $buildDir -ChildPath 'tools'
New-Item -Path $toolsDir -ItemType Directory -Force
(Get-Content -Encoding utf8 -Raw "$tplDir\chocolateyinstall.ps1.tpl").
  Replace('${version}', $version) | `
  Set-Content "$toolsDir\chocolateyinstall.ps1" -Encoding utf8

if (-not (Test-Path env:ChocolateyInstall)) {
  Write-Error "Env var ChocolateyInstall doesn't exist. Is Chocolatey installed?"
}

$chocoBinDir = Join-Path -Path $env:ChocolateyInstall -ChildPath 'bin'
Invoke-Expression "$chocoBinDir\cpack.exe $buildDir\cloudfoundry-cli.nuspec"

Write-Output ''
Write-Output 'To push the build artifact to Chocolatey.org run:'
Write-Output "choco push $buildDir\cloudfoundry-cli.$version.nupkg"
