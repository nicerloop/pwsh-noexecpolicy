@echo off
setlocal enabledelayedexpansion

echo Ensure WinGet is available
set "WINGET=%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe"
if not exist "%WINGET%" (
    echo Installing WinGet...
    call powershell -Command "irm asheroto.com/winget | iex"
) else (
    echo WinGet is already installed.
)

echo Ensure Git is available
for /f "usebackq tokens=*" %%i in (`where git`) do set "WHERE_GIT=%%i"
set "GIT=%PROGRAMFILES%\Git\bin\git.exe"
if not defined WHERE_GIT (
    if not exist "%GIT%" (
        echo Installing Git...
        call "%WINGET%" install --source=winget "Git.Git"
    ) else (
        echo Git found at %GIT%
    )
) else (
    set "GIT=%WHERE_GIT%"
    echo Git found at %GIT%
)

echo Ensure Pwsh is available
for /f "usebackq tokens=*" %%i in (`where pwsh`) do set "WHERE_PWSH=%%i"
set "PWSH=%PROGRAMFILES%\PowerShell\7\pwsh.exe"
if not defined WHERE_PWSH (
    if not exist "%PWSH%" (
        echo Installing PowerShell...
        call "%WINGET%" install --source=winget "Microsoft.Powershell"
    ) else (
        echo PowerShell found at %PWSH%
    )
) else (
    set "PWSH=%WHERE_PWSH%"
    echo PowerShell found at %PWSH%
)

echo Enable long paths support
call reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /f /v "LongPathsEnabled" /t REG_DWORD /d "1"

echo Ensure Visual Studio Code is available
for /f "usebackq tokens=*" %%i in (`where code`) do set "WHERE_VSCODE=%%i"
set "VSCODE=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
if not defined WHERE_VSCODE (
    if not exist "%VSCODE%" (
        echo Installing Visual Studio Code...
        call "%WINGET%" install --source=winget "Microsoft.VisualStudioCode"
    ) else (
        echo Visual Studio Code found at %VSCODE%
    )
) else (
    set "VSCODE=%WHERE_VSCODE%"
    echo Visual Studio Code found at %VSCODE%
)

echo Ensure 7zip is available
for /f "usebackq tokens=*" %%i in (`where 7z`) do set "WHERE_SEVENZIP=%%i"
set "SEVENZIP=%ProgramFiles%\7-Zip\7z.exe"
if not defined WHERE_SEVENZIP (
    if not exist "%SEVENZIP%" (
        echo Installing 7zip...
        call "%WINGET%" install --source=winget "7zip.7zip"
    ) else (
        echo 7zip found at %SEVENZIP%
    )
) else (
    set "SEVENZIP=%WHERE_SEVENZIP%"
    echo 7zip found at %SEVENZIP%
)

echo Restart OpenSSSHD service to pick up new PATH
call powershell -Command "Restart-Service sshd"
