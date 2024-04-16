# Write-Host "Get PowerShell sources for version 7.4.2"
git clone https://github.com/PowerShell/PowerShell.git
Set-Location PowerShell
git checkout v7.4.2
git reset
git clean -xdf

# Write-Host "Disable ExecutionPolicy"
$secFile="src/System.Management.Automation/security/SecuritySupport.cs"
$oldFile="$secFile.orig"
if (!(Test-Path $oldFile)) {
    Move-Item $secFile $oldFile
} else {
    Remove-Item $secFile
}
Get-Content $oldFile | ForEach-Object { $_ -replace "#if UNIX", "#if !UNIX" } | Set-Content $secFile

Write-Host "Compile PowerShell"
# https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md
Import-Module ./build.psm1
Start-PSBuild -ReleaseTag v7.4.2-noexecpolicy
Compress-Archive -Path src/powershell-win-core/bin/Debug/net8.0/win7-x64/publish/* -DestinationPath C:/vagrant/PowerShell-NoExecPolicy-7.4.2-win-x64.zip -Force
