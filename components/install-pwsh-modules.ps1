# Via https://stackoverflow.com/a/56893689
Function Install-ModuleIfNotInstalled(
    [string] [Parameter(Mandatory = $true)] $moduleName,
    [string] $minimalVersion
) {
    $module = Get-Module -Name $moduleName -ListAvailable |`
        Where-Object { $null -eq $minimalVersion -or $minimalVersion -lt $_.Version } |`
        Select-Object -Last 1
    if ($null -ne $module) {
         Write-Verbose ('Module {0} (v{1}) is available.' -f $moduleName, $module.Version)
    }
    else {
        Import-Module -Name 'PowershellGet'
        $installedModule = Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue
        if ($null -ne $installedModule) {
            Write-Verbose ('Module [{0}] (v {1}) is installed.' -f $moduleName, $installedModule.Version)
        }
        if ($null -eq $installedModule -or ($null -ne $minimalVersion -and $installedModule.Version -lt $minimalVersion)) {
            Write-Verbose ('Module {0} min.vers {1}: not installed; check if nuget v2.8.5.201 or later is installed.' -f $moduleName, $minimalVersion)
            #First check if package provider NuGet is installed. Incase an older version is installed the required version is installed explicitly
            if ((Get-PackageProvider -Name NuGet -Force).Version -lt '2.8.5.201') {
                Write-Warning ('Module {0} min.vers {1}: Install nuget!' -f $moduleName, $minimalVersion)
                Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force
            }        
            $optionalArgs = New-Object -TypeName Hashtable
            if ($null -ne $minimalVersion) {
                $optionalArgs['RequiredVersion'] = $minimalVersion
            }  
            Write-Warning ('Install module {0} (version [{1}]) within scope of the current user.' -f $moduleName, $minimalVersion)
            Install-Module -Name $moduleName @optionalArgs -Scope CurrentUser -Force -Verbose
        } 
    }
}

$VerbosePreference = "SilentlyContinue"

Install-ModuleIfNotInstalled PSReadLine
Install-ModuleIfNotInstalled DirColors
Install-ModuleIfNotInstalled Recycle
Install-ModuleIfNotInstalled BurntToast
Install-ModuleIfNotInstalled ZLocation
Install-ModuleIfNotInstalled posh-alias
