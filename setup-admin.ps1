# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if (-Not $myWindowsPrincipal.IsInRole($adminRole)) {
    # We are not running "as Administrator" - so relaunch as administrator

    # Create a new process object that starts PowerShell
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

    # Specify the current script path and name as a parameter
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;

    # Indicate that the process should be elevated
    $newProcess.Verb = "runas";

    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess);

    # Exit from the current, unelevated, process
    exit
}

$ErrorActionPreference = "Continue"

. $PSScriptRoot\components\common.ps1

# Install winget
if (-Not (Get-Command winget -ErrorAction SilentlyContinue))
{
    Write-Verbose "Installing winget"
    $vclibs = "$Downloads\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    if (-Not (Test-Path $vclibs)) {
        Start-BitsTransfer https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -Destination $Downloads
    }
    $appinstaller = "$Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    if (-Not (Test-Path $appinstaller)) {
        Start-BitsTransfer https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -Destination $Downloads
    }

    Add-AppxPackage $appinstaller -DependencyPath $vclibs
}

# Enable WSL, WSL 2, Sandbox
try {
    # Features don't work inside a Sandbox
    Get-WindowsOptionalFeature -Online -ErrorAction SilentlyContinue | Out-Null
    if (-Not $error)
    {
        Write-Verbose "Enabling WSL"

        # Enable WSL
        $feature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        if (-Not $feature)
        {
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
        }

        # Enable Virtual Machine Platform for WSL 2
        $feature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
        if (-Not $feature)
        {
            Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
        }

        # Enable Windows Sandbox
        $feature = Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM
        if (-Not $feature)
        {
            Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -All -NoRestart
        }
    }
}
catch {
}

# Refresh $env:Path
RefreshEnvPath

# Install GUI apps
winget import $PSScriptRoot\components\winget.json

# Configuration
. $PSScriptRoot\components\configure-admin.ps1
