function Create-Weekly-Files {
    param (
        [int]$year,
        [string]$savePath
    )
    # Create directory if it doesn't exist
    if (!(Test-Path -Path $savePath)) {
        New-Item -ItemType Directory -Path $savePath -Force
    }

    # Find the first week that belongs to our year
    $jan4 = Get-Date -Year $year -Month 1 -Day 4
    $daysUntilMonday = ($jan4.DayOfWeek.value__ + 6) % 7
    $firstMonday = $jan4.AddDays(-$daysUntilMonday)

    # Calculate all weeks
    $weekList = @()
    $currentDate = $firstMonday
    
    # We'll generate 52 weeks (standard ISO year)
    for ($i = 0; $i -lt 52; $i++) {
        $startWeek = $currentDate.AddDays(7 * $i)
        $endWeek = $startWeek.AddDays(6)
        
        $weekNumber = $i + 1

        $weekInfo = @{
            StartDate = $startWeek
            EndDate = $endWeek
            WeekNumber = $weekNumber
        }
        $weekList += $weekInfo
    }

    # Create files
    $counter = 1
    foreach ($week in $weekList) {
        $fileName = "{0:D3} Week {1:D2} - {2} - {3}.docx" -f $counter, 
            $week.WeekNumber, 
            $week.StartDate.ToString("dd.MM.yyyy"), 
            $week.EndDate.ToString("dd.MM.yyyy")
        
        $fullPath = Join-Path -Path $savePath -ChildPath $fileName
        New-Item -Path $fullPath -ItemType "file" -Force
        Write-Host "Created: $fileName"
        $counter++
    }

    Write-Host "`nCreated $($counter-1) week files for year $year"
}

# Get user input for year and save location
$userYear = Read-Host "Enter the year (e.g., 2025, 2026, 2027, 2028, or 2029)"
$savePath = Read-Host "Enter the save location path"

# Convert year to integer
$yearInt = [int]$userYear

# Call the function with user inputs
Create-Weekly-Files -year $yearInt -savePath $savePath
