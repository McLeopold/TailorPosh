function Get-Tailor {
    param
    (
        [Parameter(Mandatory=$true)]
        [string[]]$files,
        [long]$tail = 1
    )

    function highlight
    {
        Begin
        {
            $settings = Get-Content "Tailor.json" | ConvertFrom-Json
        }
        Process
        {
            $matched = $false
            foreach ($setting in $settings.rules) {
                if ($_ -match $setting.match) {
                    $matched = $true
                    Write-Host $_ -ForegroundColor $setting.color
                    break
                }
            }
            if (-not $matched -and $settings.default.enabled)
            {
                Write-Host $_ -ForegroundColor $settings.default.color
            }
        }
    }

    workflow tailor
    {
        param
        (
            [string[]]$files,
            [long]$tail
        )
        foreach -parallel ($file in $files) 
        {
            Get-Content -Tail $tail $file -wait
        }
    }

    $ProgressPreference='SilentlyContinue'
    tailor $files $tail | highlight
}