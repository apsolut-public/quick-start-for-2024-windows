function Create-Weekly-Files {
    param (
        [int]$year
    )
    $firstDayOfYear = Get-Date -Year $year -Month 1 -Day 1

    for ($i = 0; $i -lt 52; $i++) {
        $startWeek = $firstDayOfYear.AddDays(7 * $i)
        $endWeek = $startWeek.AddDays(6)
        $fileName = "{0:D3} Week {1:D2} - {2} - {3}.docx" -f ($i + 1), ($i + 1), $startWeek.ToString("dd.MM.yyyy"), $endWeek.ToString("dd.MM.yyyy")

        # Create an empty file with the specified name
        New-Item -Path . -Name $fileName -ItemType "file"
    }
}

# Call the function with the desired year
Create-Weekly-Files -year 2024