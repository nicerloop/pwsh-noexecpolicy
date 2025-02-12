$PowerShellVersion="7.5.0"
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

Write-Host "Ignore Windows Software Restriction Policies API"
git apply C:/vagrant/IgnoreSafer.patch

Write-Host "Compile PowerShell"
# https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md
Import-Module ./build.psm1
Install-Dotnet
Start-PSBuild -Clean -PSModuleRestore -UseNuGetOrg -ReleaseTag v$PowerShellVersion -ForMinimalSize -Configuration Release

Write-Host "Archive PowerShell"
Compress-Archive -Path src/powershell-win-core/bin/Release/net9.0/win7-x64/publish/* -DestinationPath C:/vagrant/PowerShell-NoGpoExecPolicy-$PowerShellVersion-win-x64.zip -Force
