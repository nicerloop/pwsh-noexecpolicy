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

Write-Host "Install .Net SDK"
scoop install main/dotnet-sdk
