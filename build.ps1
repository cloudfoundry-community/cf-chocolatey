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

(Get-Content "$tplDir/cloudfoundry-cli.nuspec.tpl" -Raw).
  Replace('${version}', $version).Replace('${buildDir}', $buildDir) | `
  Set-Content "$buildDir/cloudfoundry-cli.nuspec" -Encoding utf8NoBOM

$toolsDir = Join-Path -Path $buildDir -ChildPath 'tools'
New-Item -Path $toolsDir -ItemType Directory -Force
(Get-Content "$tplDir/chocolateyinstall.ps1.tpl" -Raw).
  Replace('${version}', $version) | `
  Set-Content "$toolsDir/chocolateyinstall.ps1" -Encoding utf8BOM

if (-not (Test-Path env:ChocolateyInstall)) {
  Write-Error "Env var ChocolateyInstall doesn't exist. Is Chocolatey installed?"
}

$chocoBinDir = Join-Path -Path $env:ChocolateyInstall -ChildPath 'bin'
Invoke-Expression "$chocoBinDir/cpack.exe $buildDir/cloudfoundry-cli.nuspec"

Write-Output "Run:"
Write-Output "choco push $buildDir/cloudfoundry-cli.$version.nupkg"
Write-Output "to push the build artifact to Chocolatey.org"
