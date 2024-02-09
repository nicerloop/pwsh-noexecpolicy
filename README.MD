# PowerShell Core custom build

Rebuild to use Unix Unrestricted ExecutionPolicy

[Build PowerShell on Windows for .NET Core](https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md)

[SecuritySupport.cs](https://github.com/PowerShell/PowerShell/blob/v7.4.1/src/System.Management.Automation/security/SecuritySupport.cs#L282)

## Instructions

```
vagrant up
vagrant provision
vagrant ssh -- pwsh c:/vagrant/build.ps1
```
