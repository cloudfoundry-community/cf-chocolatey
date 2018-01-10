<?xml version="1.0" encoding="utf-8"?>
<!-- Do not remove this test for UTF-8: if “Ω” doesn’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one. -->
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
    <metadata>
        <!-- Read this before publishing packages to chocolatey.org: https://github.com/chocolatey/chocolatey/wiki/CreatePackages -->
        <id>cloudfoundry-cli</id>
        <title>Cloud Foundry CLI</title>
        <version>${version}</version>
        <authors>Cloud Foundry Foundation</authors>
        <owners>Shawn Neal</owners>
        <summary>Install official command line client for Cloud Foundry.</summary>
        <description>Cloud Foundry CLI is the official command line client for Cloud Foundry
        </description>
        <projectUrl>https://github.com/cloudfoundry/cli</projectUrl>
        <tags>cf cloudfoundry cloud pivotal</tags>
        <copyright>Cloud Foundry Foundation</copyright>
        <licenseUrl>https://raw.githubusercontent.com/cloudfoundry/cli/master/LICENSE</licenseUrl>
        <requireLicenseAcceptance>false</requireLicenseAcceptance>
        <iconUrl>https://cdn.rawgit.com/cloudfoundry-community/cf-chocolatey/master/icons/cf.png</iconUrl>
        <packageSourceUrl>https://github.com/cloudfoundry-community/cf-chocolatey</packageSourceUrl>
    </metadata>
    <files>
        <file src="tools\*.*" target="tools"/>
    </files>
</package>
