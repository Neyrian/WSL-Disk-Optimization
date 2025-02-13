# Shutdown WSL and kill WSL service
wsl --shutdown
Stop-Service -Name "LxssManager" -Force -ErrorAction SilentlyContinue
Stop-Service -Name "wslservice" -Force -ErrorAction SilentlyContinue

# List WSL distributions
$wslDistros = wsl --list --quiet

foreach ($distro in $wslDistros) {
    if ($distro -ne "") {
        try {
            # Retrieve the location of the ext4.vhdx file
            $vhdxPath = (Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq $distro }).GetValue("BasePath") + "\ext4.vhdx"

            if ($vhdxPath) {
                # Create a diskpart script to compact the vdisk
                $diskpartScript = @"
select vdisk file="$vhdxPath"
attach vdisk readonly
compact vdisk
detach vdisk
exit
"@

                # Execute the diskpart script
                $diskpartScript | diskpart
                Write-Host "Succesfully shrink " $distro
            }
        } catch {
            Write-Host "Fail to locate virtual disk of: " + $distro
        }
    }
}

# Restart WSL service
Start-Service -Name "LxssManager" -ErrorAction SilentlyContinue
Start-Service -Name "wslservice" -ErrorAction SilentlyContinue
