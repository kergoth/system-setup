# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($myWindowsPrincipal.IsInRole($adminRole)) {
    # We are running "as Administrator" - so relaunch as user

    $cmd = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -WindowStyle Maximized -NoProfile -InputFormat None -ExecutionPolicy RemoteSigned -File " + $MyInvocation.MyCommand.Definition
    runas /trustlevel:0x20000 $cmd
    exit
}

. $PSScriptRoot\components\windows\common.ps1

# Install PowerShell modules
. $PSScriptRoot\components\windows\install-pwsh-modules.ps1

# Add installed software to the user's PATH and/or startup
if (Test-Path "C:\Program Files\7-Zip") {
    Add-EnvironmentVariableItem "PATH" "C:\Program Files\7-Zip" -User
}

# Run SyncTrayzor, which will add itself to startup
if (Test-Path "C:\Program Files\SyncTrayzor") {
    Start-Process "C:\Program Files\SyncTrayzor\SyncTrayzor.exe" -ArgumentList --minimized
}

# Use RemoteSigned execution policy for PowerShell. Needed for scoop, etc.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install scoop
if (-Not $env:SCOOP)
{
    $env:SCOOP = "$env:USERPROFILE/scoop"
}
if (-Not (Test-Path "$env:SCOOP"))
{
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}
RefreshEnvPath

# Install languages
scoop install rust go python
$reg = Get-ChildItem $env:USERPROFILE\scoop\apps\python\*\install-pep-514.reg -ErrorAction SilentlyContinue | Select-Object -First 1
if ($reg) {
    Write-Host "Importing python registry entries"
    reg import $reg
}
RefreshEnvPath

python3 -m pip install --user pipx
python3 -m pipx ensurepath
RefreshEnvPath

# Windows-specific
scoop install sudo gow starship

# Install core
# Unavailable on Windows: tmux, zsh
scoop install git
scoop install neovim
scoop install wget

# Add scoop's Git for Windows bin directory to the PATH for its bash
$gitdir = scoop prefix git
Add-EnvironmentVariableItem "PATH" "$gitdir\bin" -User

# Add cargo bindir to the PATH
Add-EnvironmentVariableItem "PATH" "$env:USERPROFILE\.cargo\bin" -User

# Install tools
# Unavailable on Windows: direnv
scoop install bat
scoop install fd
scoop install ripgrep
scoop install zoxide
scoop install fzf

try {
    $VSInstall = (Get-VSSetupInstance | Where-Object DisplayName -Match 'Build Tools' | Sort-Object -Property InstallationVersion | Select-Object -Last 1 -ExpandProperty InstallationPath)
    $VSTools = $VSInstall + "/Common7/Tools"
    if (Test-Path $VSTools) {
        . ($VSTools + "/Launch-VsDevShell.ps1")
    }

    cargo install --git https://github.com/ogham/exa
}
catch {
    Write-Error "Failed to install exa. Please make sure the Visual Studio Build Tools with the C++ Desktop workload is installed."
}

scoop install gh
scoop install delta
scoop install shfmt
scoop install shellcheck
scoop install jq
cargo install choose
scoop install sd

# Disk tools
scoop install dua
scoop install dust

pip install --user git-revise
pip install --user git-imerge

# git-absorb is available only via release archives on Windows. It fails to build with cargo.
if (-Not (Test-Path "$env:USERPROFILE\.cargo\bin\git-absorb.exe")) {
    $DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
    $absorb_url = Get-GithubLatestRelease tummychow/git-absorb pc-windows-msvc
    $absorb = "$DownloadsFolder\" + (Split-Path $absorb_url -Leaf)
    if (-Not (Test-Path $absorb)) {
        Start-BitsTransfer $absorb_url -Destination $DownloadsFolder
    }
    $absorbtemp = "$env:TEMP\absorb"
    try {
        Expand-Archive "$absorb" -DestinationPath $absorbtemp -Force
        $absorbdir = (Get-ChildItem -Path $absorbtemp | Select-Object -First 1).FullName
        Move-Item "$absorbdir\git-absorb.exe" -Destination "$env:USERPROFILE\.cargo\bin\"
    }
    finally {
        Remove-Item $absorbtemp -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# npiperelay, for wsl access to Windows ssh-agent
if (-Not (Test-Path "$env:USERPROFILE/Apps/npiperelay/npiperelay.exe")) {
    $DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
    $npiperelay_url = Get-GithubLatestRelease jstarks/npiperelay windows_amd64
    $npiperelay = "$DownloadsFolder\" + (Split-Path $npiperelay_url -Leaf)
    if (-Not (Test-Path $npiperelay)) {
        Start-BitsTransfer $npiperelay_url -Destination $DownloadsFolder
    }
    $npiperelaytemp = "$env:TEMP\npiperelay"
    $npiperelaydir = "$env:USERPROFILE\Apps\npiperelay"

    try {
        Expand-Archive "$npiperelay" -DestinationPath $npiperelaytemp -Force
        if (-Not (Test-Path $npiperelaydir)) {
            New-Item $niperelaydir -Type Directory
        }
        Move-Item "$npiperelaytemp\npiperelay.exe" -Destination "$env:USERPROFILE\Apps\npiperelay\"
    }
    finally {
        Remove-Item $npiperelaytemp -Recurse -Force -ErrorAction SilentlyContinue
    }
}

RefreshEnvPath

Write-Output "Setup complete"
