# Import the WebAdministration module to manage IIS
Import-Module WebAdministration

# Define the local website directories
$websiteDirs = @(
    "C:\inetpub\wwwroot\website1",
    "C:\inetpub\wwwroot\website2"
)

# Ensure the website directories exist
foreach ($dir in $websiteDirs) {
    if (-Not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created directory: $dir"
    }
}

# Define the backup directory
$backupDir = "C:\backup"
if (-Not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    Write-Host "Created backup directory: $backupDir"
}

# Backup the websites by zipping the directories
foreach ($dir in $websiteDirs) {
    $websiteName = Split-Path $dir -Leaf
    $zipPath = Join-Path $backupDir "$websiteName.zip"
    
    if (Test-Path $zipPath) {
        Remove-Item $zipPath -Force
        Write-Host "Removed existing backup: $zipPath"
    }
    
    Compress-Archive -Path $dir -DestinationPath $zipPath
    Write-Host "Backed up $websiteName to $zipPath"
}

# Stop and remove existing IIS websites
$websiteNames = @("website1", "website2")
foreach ($name in $websiteNames) {
    if (Get-Website -Name $name -ErrorAction SilentlyContinue) {
        Stop-Website -Name $name
        Remove-Website -Name $name
        Write-Host "Removed existing website: $name"
    }
}

# Delete current website directories
foreach ($dir in $websiteDirs) {
    if (Test-Path $dir) {
        Remove-Item -Path $dir -Recurse -Force
        Write-Host "Deleted directory: $dir"
    }
}

# Define remote locations for new website content
$remoteDirs = @(
    "\\remoteServer\share\website1",
    "\\remoteServer\share\website2"
)

# Copy new website content from remote locations
for ($i = 0; $i -lt $websiteDirs.Count; $i++) {
    $localDir = $websiteDirs[$i]
    $remoteDir = $remoteDirs[$i]
    Copy-Item -Path $remoteDir -Destination $localDir -Recurse -Force
    Write-Host "Copied content from $remoteDir to $localDir"
}

# Recreate IIS websites and start them under the same application pool
$applicationPool = "DefaultAppPool"
$startPort = 80  # Starting port number

for ($i = 0; $i -lt $websiteNames.Count; $i++) {
    $name = $websiteNames[$i]
    $physicalPath = $websiteDirs[$i]
    $port = $startPort + $i  # Increment port for each website
    
    New-Website -Name $name -PhysicalPath $physicalPath -Port $port -ApplicationPool $applicationPool
    Start-Website -Name $name
    Write-Host "Created and started website: $name on port $port"
}
