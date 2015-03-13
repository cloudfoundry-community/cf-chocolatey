<?php
echo '#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = \'Stop\';


$packageName = \'cf\'
$registryUninstallerKeyName = \'cf\'
$version = "' . $version . '"
$url = "https://cli.run.pivotal.io/stable?release=windows32-exe&version=$($version)&source=github-rel"
$url64 = "https://cli.run.pivotal.io/stable?release=windows64-exe&version=$($version)&source=github-rel"
$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)


Install-ChocolateyZipPackage "$packageName" "$url" "$installDir" "$url64"';
