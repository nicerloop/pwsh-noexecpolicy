$PowerShellVersion="7.4.3"
Write-Host "Get PowerShell sources for version $PowerShellVersion"
git clone https://github.com/PowerShell/PowerShell.git
Set-Location PowerShell
git checkout v$PowerShellVersion
git reset
git clean -xdf

Write-Host "Disable ExecutionPolicy"
$secFile="src/System.Management.Automation/security/SecuritySupport.cs"
$oldFile="$secFile.orig"
if (!(Test-Path $oldFile)) {
    Move-Item $secFile $oldFile
} else {
    Remove-Item $secFile
}
Get-Content $oldFile | ForEach-Object { $_ -replace "#if UNIX", "#if !UNIX" -replace "throw new PlatformNotSupportedException", "// throw new PlatformNotSupportedException" } | Set-Content $secFile

Write-Host "Compile PowerShell"
# https://github.com/PowerShell/PowerShell/blob/master/docs/building/windows-core.md
Import-Module ./build.psm1
Install-Dotnet
Start-PSBuild -ReleaseTag v$PowerShellVersion
Compress-Archive -Path src/powershell-win-core/bin/Debug/net8.0/win7-x64/publish/* -DestinationPath C:/vagrant/PowerShell-NoExecPolicy-$PowerShellVersion-win-x64.zip -Force
