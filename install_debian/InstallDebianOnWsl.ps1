# Installs Debian/Ubuntu on Windows via WSL2

function delimiter() { Write-Host "---------------------------------" }
function installPackage([string]$distribution) {
    delimiter
    Write-Host "getting $distribution archive ..."
    delimiter

    if ($distribution -eq "ubuntu") { $path="wslubuntu"}
    if ($distribution -eq "debian") { $path="wsl-debian-gnulinux"}

    curl https://aka.ms/$path -L -o "./$distribution.zip"
    Expand-Archive "./$distribution.zip" -DestinationPath ./$distribution -Force
    cd $distribution
    $package=ls *._x64.appx
    Import-Module Appx -UseWindowsPowerShell
    Add-AppxPackage $package
    wsl --install --distribution $distribution
    cd ..
    Remove-Item $distribution -Force -Recurse

    $userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
    [System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";C:\Users\Administrator\$distribution", "User")
}

cd ~/Downloads
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Enable-WindowsOptionalFeature -Online FeatureName Microsoft-Windows-Subsystem-Linux
Get-WindowsOptionalFeature -Online FeatureName Microsoft-Windows-Subsystem-Linux

installPackage debian
# installPackage ubuntu

debian