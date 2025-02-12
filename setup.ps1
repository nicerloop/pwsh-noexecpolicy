# Prevent issues with CLI non-interactive execution
# https://github.com/PowerShell/Microsoft.PowerShell.Archive/issues/77#issuecomment-601947496
Write-Host "Disable progress bars for CLI non-interactive execution"
$ProgressPreference = "SilentlyContinue"
$global:ProgressPreference = "SilentlyContinue"

Write-Host "Install Scoop (https://scoop.sh)"
if (Get-Command -ErrorAction SilentlyContinue scoop) {
    Write-Host "Scoop already installed"
}
else {
    # https://github.com/ScoopInstaller/Install#for-admin
    Invoke-Expression "& {$(Invoke-RestMethod `"https://get.scoop.sh`")} -RunAsAdmin"
}

Write-Host "Install Powershell Core"
scoop install main/pwsh

Write-Host "Install git"
scoop install main/git
