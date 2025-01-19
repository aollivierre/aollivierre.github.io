# Download Python installer
$pythonUrl = "https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe"
$installerPath = "$env:TEMP\python-installer.exe"
Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath

# Install Python with pip
Start-Process -FilePath $installerPath -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait

# Clean up installer
Remove-Item $installerPath

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")