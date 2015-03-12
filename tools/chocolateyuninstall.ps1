#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = 'Stop';

# Auto Uninstaller should be able to detect and handle registry uninstalls (if it is turned on, it is in preview for 0.9.9).

$packageName = 'cf'
$registryUninstallerKeyName = 'cf' #ensure this is the value in the registry
$file = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)/cf.exe"
$validExitCodes = @(0)

#$osBitness = Get-ProcessorBits

#if ($osBitness -eq 64) {
#  $file = (Get-ItemProperty -Path "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName").UninstallString
#} else {
#  $file = (Get-ItemProperty -Path "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName").UninstallString
#}
#
Uninstall-ChocolateyPackage -PackageName $packageName -validExitCodes $validExitCodes -File $file
