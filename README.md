# cf-chocolatey
A chocolatey package to install official command line client for Cloud Foundry.

##Installation

 1. Install chocolatey (follow instructions chocolatey: `https://chocolatey.org/`
 2. Run in your prefered cli `$ choco install cf`
 3. You've done.

##Rebuild
To maintain always up-to-date this choco package with [https://github.com/cloudfoundry/cli](https://github.com/cloudfoundry/cli) I've made a php script which can be run everyday.

To try it run with php in cli command `$ php rebuild.php`.

It will:
 1. Check if version between this github and the [https://github.com/cloudfoundry/cli](https://github.com/cloudfoundry/cli) are the same
 2. Recreate `tools\chocolateyinstall.ps1` and `cf.nuspec` with this new version.
 3. Repack the nugget package with the `cpack` command.
 4. Push to `https://chocolatey.org` this new package.
