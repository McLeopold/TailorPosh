function Get-Tailor {
    param
    (
        [string[]]$files
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
            [string[]]$files
        )
        foreach -parallel ($file in $files) 
        {
            Get-Content -Tail 1 $file -wait
        }
    }

    tailor $files | highlight
}