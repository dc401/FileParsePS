FileParsePS
===========

File Parser that can parse through data for delimiters and substitute them and additionally search/grep for a string for more focused output.

The original one liner is included in parse_delim.ps1 or string_parse_delim.ps1 that includes an additional 
ability [that I can’t seem to get working in the script] to select which fields you want on the output.. 
e.g. if you only want fields 1 through 3; you could use “1..3” or if you only wanted fields 1 and 3; you could use “1,3”.

Original one liner: findstr "base" .\oui.txt | ForEach-Object {$_ -replace "\s+|\t",","} | %{ $_.Split(',')[1..3] -join ','};

What it does: 
Option 1 – You can add a string to search for a file in, think of it as “grep” so you can only get items you want 
such as a common field or row
Option 2 – Only parse based on the delimiter specified and replace with the one specified.

Why: 
A use case would be if you’re parsing a huge file that crashes notepad or excel or a file with a ton of lines or 
other data you need to shift through and turn into something like a CSV; or turn a CSV into any other 
delimited file format compatible for whatever your need is. For instance,
If you have “A  B   C”  it would crash. This script allows you to specify something like “\t” as a single tab delimiter and turn this data into something like “A,B,C” or “A:B:C”.

Notes: If you want to increase performance or just don’t care, you can comment out Write-Progress within the 
ForEach-Object loop to increase your I/O throughput.

How to use it: Open the launcher “file_parse_launcher.bat”

