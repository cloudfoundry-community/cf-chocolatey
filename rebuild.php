<?php
/**
 * Copyright (C) 2014 Arthur Halet
 *
 * This software is distributed under the terms and conditions of the 'MIT'
 * license which can be found in the file 'LICENSE' in this package distribution
 * or at 'http://opensource.org/licenses/MIT'.
 *
 * Author: Arthur Halet
 * Date: 13/03/2015
 */
$versionFile = __DIR__ . '/VERSION';
$versionChoco = rtrim(file_get_contents($versionFile));
$versionGithub = rtrim(file_get_contents('https://raw.githubusercontent.com/cloudfoundry/cli/master/VERSION'));
if ($versionChoco == $versionGithub) {
    echo "Everything up-to-date.";
    exit(0);
}
$chocoInstallFolder = getenv("ChocolateyInstall") . "\\bin";
if (!is_dir($chocoInstallFolder)) {
    exit(sprintf("Folder %s not valid.", $chocoInstallFolder));
}
$version = $versionGithub;
$buildDir = realpath(__DIR__);

mkdir(__DIR__ . '/tools');
ob_start();
include_once __DIR__ . '/template/cf.nuspec.php';
file_put_contents(__DIR__ . '/cf.nuspec', ob_get_contents());
ob_end_clean();

ob_start();
include_once __DIR__ . '/template/chocolateyinstall.ps1.php';
file_put_contents(__DIR__ . '/tools/chocolateyinstall.ps1', ob_get_contents());
ob_end_clean();

exec($chocoInstallFolder . '\\cpack.exe "' . realpath(__DIR__ . '/cf.nuspec') . '"', $output, $returnVar);
echo implode("\n", $output);
echo "\n";
flush();
if ($returnVar != 0) {
    echo "exiting";
    exit(1);
}
exec($chocoInstallFolder . '\\choco.exe push "' . realpath(__DIR__ . '/cf.' . $version . '.nupkg') . '"', $output);
echo implode("\n", $output);
echo "\n";
flush();
if ($returnVar != 0) {
    echo "exiting";
    exit(1);
}
file_put_contents($versionFile, $version);
echo "\nUpdate done.";
exit(0);