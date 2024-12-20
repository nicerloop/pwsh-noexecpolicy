$PowerShellVersion="7.4.6"
Write-Host "Get PowerShell sources for version $PowerShellVersion"
git clone https://github.com/PowerShell/PowerShell.git
Set-Location PowerShell
git config advice.detachedHead false
git checkout v$PowerShellVersion
git reset
git restore .
git clean -xdf

Write-Host "Ignore GPO Execution Policy scopes"
git apply C:/vagrant/IgnoreGpoExecutionPolicyScope.patch

Write-Host "Ignore Windows LockDown Policy application white listing"
git apply C:/vagrant/IgnoreWldp.patch

Write-Host "Disable NuGet Audit to reproduce build"
git apply C:/vagrant/DisableNuGetAudit.patch

Write-Host "Compile PowerShell"
# https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md
Import-Module ./build.psm1
Install-Dotnet
Start-PSBuild -ReleaseTag v$PowerShellVersion -ForMinimalSize

Write-Host "Archive PowerShell"
Compress-Archive -Path src/powershell-win-core/bin/Debug/net8.0/win7-x64/publish/* -DestinationPath C:/vagrant/PowerShell-NoGpoExecPolicy-$PowerShellVersion-win-x64.zip -Force
