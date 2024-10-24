# PowerShell Core custom build

Rebuild to ignore GPO ExecutionPolicy scopes

[Build PowerShell on Windows for .NET Core](https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md)

[SecuritySupport.cs](https://github.com/PowerShell/PowerShell/blob/v7.4.6/src/System.Management.Automation/security/SecuritySupport.cs#L127)

## Instructions

```
vagrant up
vagrant ssh -- pwsh c:/vagrant/build.ps1
```
