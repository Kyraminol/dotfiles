function New-ChezmoiJunctions {
    param (
        [Parameter(Mandatory=$true)]
        [PSCustomObject[]]$Configurations
    )

    if ($PSVersionTable.PSVersion.Major -le 5 -or $isWindows) {
        foreach ($config in $Configurations) {
            $sourcePath = $config.SourcePath
            $destinationPath = $config.DestinationPath

            if (-Not (Test-Path $destinationPath)) {
                New-Item -Path $destinationPath -ItemType Junction -Value $sourcePath -ErrorAction Continue
            }
        }
    }
}

$junctionConfigs = @(
    @{
        SourcePath = "$env:USERPROFILE\.config\nvim"
        DestinationPath = "$env:LOCALAPPDATA\nvim"
    },
    @{
        SourcePath = "$env:USERPROFILE\.config\nushell"
        DestinationPath = "$env:APPDATA\nushell"
    }
)

Write-Output "Creating junctions..."
New-ChezmoiJunctions -Configurations $junctionConfigs
Write-Output "Junctions created"
