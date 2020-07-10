Write-Host "[i] Creating output folder structure" -ForegroundColor Yellow
Remove-Item .\out -Recurse -ErrorAction Ignore
New-Item -ItemType directory -Path .\out > $null
New-Item -ItemType directory -Path .\out\ACPI > $null

Write-Host "[i] Compiling SSDTs" -ForegroundColor Yellow
Get-ChildItem .\raw\ACPI -Filter *.dsl |
Foreach-Object {
    $output = .\Tools\iasl.exe $_.FullName 2>&1
    if (!($output -match "0 Errors")) {
        Write-Host "[X] Error while compiling SSDT $($_.BaseName)" -ForegroundColor Red
        Write-Host $output
        exit
    }
    Move-Item -Path .\raw\ACPI\$($_.BaseName + ".aml") -Destination .\out\ACPI\
}

Write-Host "[√] SSDTs compiled" -ForegroundColor Green

Write-Host "[i] Copying kexts, drivers and config file" -ForegroundColor Yellow
Copy-Item -Path .\raw\Kexts -Recurse .\out\Kexts > $null
Copy-Item -Path .\raw\Drivers -Recurse .\out\Drivers > $null
Copy-Item -Path .\raw\Resources -Recurse .\out\Resources > $null

Copy-Item -Path .\raw\config.plist .\out\config.plist > $null
Copy-Item -Path .\raw\OpenCore.efi .\out\OpenCore.efi > $null


Write-Host "[√] All good!" -ForegroundColor Green