# PowerShell script to create specified folders in the current directory

# List of folder names to create
$folders = @("Design", "Discovery", "Documents", "Resources", "Tasks")

# Loop through each folder name and create the folder
foreach ($folder in $folders) {
    $path = Join-Path -Path (Get-Location) -ChildPath $folder

    # Check if the folder already exists
    if (-Not (Test-Path -Path $path)) {
        # Create the folder if it doesn't exist
        New-Item -Path $path -ItemType Directory
        Write-Host "Created folder: $folder"
    } else {
        Write-Host "Folder already exists: $folder"
    }
}
