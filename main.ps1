# Set the UseWUServer registry value to 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 0

# Stop Windows Update service
Stop-Service -Name "wuauserv" -Force

# Waiting for the service to stop
$timeout = 20
$serviceStatus = (Get-Service -Name "wuauserv").Status
while ($timeout -gt 0 -and $serviceStatus -ne "Stopped") {
    Write-Host "Waiting for Windows Update service to stop..."
    Start-Sleep -Seconds 1
    $serviceStatus = (Get-Service -Name "wuauserv").Status
    $timeout--
}

# Delete cache from SoftwareDistribution folder
Remove-Item -Path C:\Windows\SoftwareDistribution\DataStore\* -Force -Recurse

# Start Windows Update service
Start-Service -Name "wuauserv"

# Wait for the service to start
$timeout = 20
$serviceStatus = (Get-Service -Name "wuauserv").Status
while ($timeout -gt 0 -and $serviceStatus -ne "Running") {
    Write-Host "Waiting for Windows Update service to start..."
    Start-Sleep -Seconds 5
    $serviceStatus = (Get-Service -Name "wuauserv").Status
    $timeout--
}
