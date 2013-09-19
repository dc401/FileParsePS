<# 

#Version: 1.0 20130919 Author: Dennis Chow dchow [AT] xtecsystems.com
#This script is licensed under GPL v3


This script parses through any searchable file with a delimited structure and convert it to a different structure
or print 

NOTICE:
This script uses the Write-Progress function; this can slow down the parsing of a large file if you don't comment it out.
The join function was commented out as it only seems to work in CLI with no arguments passed to be able to specify which columns you wanted

Original one liner: findstr "base" .\oui.txt | ForEach-Object {$_ -replace "\s+|\t",","} | %{ $_.Split(',')[1..3] -join ','};

#>

$arg0 = Read-Host "Please enter filename.ext or full path (if file not in same dir) you wish to search"
Write-Host "You entered:" $arg0

IF (Test-Path -isvalid $arg0)
{
	#Alternative to "@(Get-Content $arg2).Length" because of memory issues in large files
	#Taken from: http://stackoverflow.com/questions/6855814/powershell-how-to-count-number-of-rows-in-csv-file
	[int]$countLines = 0
	$reader = New-Object IO.StreamReader $arg0
	while($reader.ReadLine() -ne $null){ $countLines++ }
	Write-Host "Total number of lines:" $countLines
	#Spacers for easier reading
	Write-Host " "
	$arg2 = Read-Host "What is the column/field delimiter? [you can also use PS supported regex and use | as an OR] Ex: , or \t+|\s+"
	Write-Host "You entered:" $arg2
	Write-Host " "
	$arg3 = Read-Host "What do you want to replace the existing delimiter with? Ex: , "
	Write-Host "You entered:" $arg3
	Write-Host " "
	#$arg4 = Read-Host "What column(s) # do you want to print? Ex: 3 or 1..3 or 1,2,3"
	#Write-Host "You entered:" $arg4
	Write-Host " "
	[int]$countStatus = 0
	Get-Content $arg0 | `
	ForEach-Object `
		{
			#findstr $arg1 $arg0 | ForEach-Object {$_ -replace $arg2,$arg3} | %{ $_.Split($arg3)[$arg4] -join $arg3 } | Out-File new_column_output.txt
			$_ -replace $arg2,$arg3 | Out-File delim_only_output.txt -append
			$countStatus++
			#Comment Write-Progress out if this is taking to long for very long files
			Write-Progress -Activity "Parsing..." -PercentComplete ($countStatus / $countLines) -CurrentOperation "$countStatus of $countLines"  -Status "Please wait." `
		}
	Write-Host "Wrote to delim_only_output.txt"
	Write-Host " "
	
	Write-Progress -Activity "Parsing..." -Completed -Status "Complete."
}

ELSE
{
	Write-Host "ERROR: The path or filename does not exist. Exiting..."
	exit
}
