# Open Powershell as Administrator
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
curl https://aka.ms/wsl-debian-gnulinux -o debian.zip
Expand-Archive ./debian.zip ./debian
cd debian
Add-AppxPackage ./DistroLauncher-Appx_1.12.1.0_x64.appx
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";C:\Users\Administrator\debian", "User")
debian