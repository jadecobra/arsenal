# Installs Debian/Ubuntu on Windows via WSL2

function delimiter() { Write-Host "---------------------------------" }

function setup_wsl() {
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Enable-WindowsOptionalFeature -Online FeatureName Microsoft-Windows-Subsystem-Linux
    Get-WindowsOptionalFeature -Online FeatureName Microsoft-Windows-Subsystem-Linux
}

function install_package([string]$distribution) {
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
setup_wsl
install_package debian
# install_package ubuntu

debian