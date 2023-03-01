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

. $PSScriptRoot\components\windows\common.ps1

# Install winget
if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
    $DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"

    Write-Output "Installing winget"

    $appinstaller_url = Get-GithubLatestRelease "microsoft/winget-cli" "Microsoft.DesktopAppInstaller"
    $appinstaller = "$DownloadsFolder\" + (Split-Path $appinstaller_url -Leaf)
    if (-Not (Test-Path $appinstaller)) {
        Start-BitsTransfer $appinstaller_url -Destination $DownloadsFolder
    }

    $vclibs_url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    $vclibs = "$DownloadsFolder\" + (Split-Path $vclibs_url -Leaf)
    if (-Not (Test-Path $vclibs)) {
        Start-BitsTransfer $vclibs_url -Destination $DownloadsFolder
    }

    $xaml = "$DownloadsFolder\Microsoft.UI.Xaml.2.7.appx"
    if (-Not (Test-Path "$xaml")) {
        $xaml_url = "https://globalcdn.nuget.org/packages/microsoft.ui.xaml.2.7.3.nupkg"
        $xamldl = "$DownloadsFolder\" + (Split-Path $xaml_url -Leaf)
        if (-Not (Test-Path "$xamldl.zip")) {
            Start-BitsTransfer $xaml_url -Destination $DownloadsFolder
            Move-Item "$xamldl" "$xamldl.zip"
        }
    
        $wingettemp = "$env:TEMP\winget"
        try {
            Expand-Archive "$xamldl.zip" -DestinationPath $wingettemp -Force
            Move-Item "$wingettemp\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx"  "$xaml"
        }
        finally {
            Remove-PossiblyMissingItem $wingettemp -Recurse -Force
        }
    }

    Add-AppxPackage $appinstaller -DependencyPath $vclibs, $xaml
}

# Enable WSL, WSL 2, Sandbox
try {
    # Features don't work inside a Sandbox
    Get-WindowsOptionalFeature -Online -ErrorAction SilentlyContinue | Out-Null
    if (-Not $error) {
        Write-Output "Enabling WSL"

        # Enable WSL
        $feature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        if (-Not $feature) {
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
        }

        # Enable Virtual Machine Platform for WSL 2
        $feature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
        if (-Not $feature) {
            Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
        }

        # Enable Windows Sandbox
        $feature = Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM
        if (-Not $feature) {
            Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -All -NoRestart
        }
    }
}
catch {
}

# Refresh $env:Path
RefreshEnvPath

# Install GUI apps
winget import $PSScriptRoot\components\windows\winget.json

# Install Visual Studio C++ Desktop Workload
winget install Microsoft.VisualStudio.2022.Community --silent --override "--wait --quiet --add ProductLang En-us --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"

# Configuration
. $PSScriptRoot\components\windows\configure-admin.ps1

Write-Output "Admin setup complete"
