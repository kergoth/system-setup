$ErrorActionPreference = "Continue"

. $PSScriptRoot\components\windows\common.ps1

# Install PowerShell modules
. $PSScriptRoot\components\windows\install-pwsh-modules.ps1

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
scoop bucket add extras

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

# Install tools
# Unavailable on Windows: direnv
# Available only via release archives on Windows: git-absorb
scoop install bat
scoop install fd
scoop install ripgrep
scoop install zoxide
scoop install fzf
cargo install --no-default-features --branch chesterliu/dev/win-support --git https://github.com/skyline75489/exa
scoop install gh
scoop install delta
scoop install shfmt
scoop install shellcheck
scoop install jq
cargo install choose
scoop install sd
cargo install --locked --all-features  --git https://github.com/ms-jpq/sad --branch senpai

# Disk tools
scoop install dua
scoop install dust

pipx install flake8
pipx inject flake8 pep8-naming flake8-docstrings
pipx install peru
pipx install git-revise
pipx install git-imerge

# Configuration
. $PSScriptRoot\components\windows\configure.ps1
