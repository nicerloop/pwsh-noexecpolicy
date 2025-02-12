# PowerShell Core custom build

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

Rebuild to ignore execution policies.

[Build PowerShell on Windows for .NET Core](https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md)

Build using [Vagrant](http://vagrantup.com) and [VirtualBox](https://www.virtualbox.org)

## Tasks

### build

Build PowerShell in a clean Vagrant instance

```sh
vagrant snapshot restore clean || (vagrant up && vagrant snapshot save clean)
vagrant ssh -- pwsh c:/vagrant/build.ps1
```

### clean

Remove Vagrant instance

```sh
vagrant destroy --force
```
