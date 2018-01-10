# cf-chocolatey
A [chocolatey package](https://chocolatey.org/packages/cloudfoundry-cli/) to install the official [Cloud Foundry CLI](http://docs.cloudfoundry.org/cf-cli/install-go-cli.html).

## CF CLI Installation

1. [Install chocolatey](https://chocolatey.org/install)
1. `C:\> choco install cloudfoundry-cli`

## Rebuild Chocolatey Package

You can automatically rebuild an up-to-date choco package with the latest CF CLI using the `build.ps1` script. Run the script from PowerShell specifying the version of the CF CLI you want to package, for example:

```
$ .\build.ps1 6.33.1
```

build.ps1 will:
1. Create `tools\chocolateyinstall.ps1` and `cloudfoundry-cli.nuspec` with the specified version.
1. Repack the Nuget package with the `cpack` command.
1. Output the choco push command you can then use to publish the new package.
