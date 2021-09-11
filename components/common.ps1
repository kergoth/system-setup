Import-Module -Name BitsTransfer

function RefreshEnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Remove-PossiblyMissingItem {
    try {
        Remove-Item @args -ErrorAction Stop
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        $null
    }
}
