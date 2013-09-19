@echo off
REM turns off script execution restrictions for Powershell
REM Version: 1.0 20130919 Author: Dennis Chow dchow [AT] xtecsystems.com
REM This script is licensed under GPL v3

echo About:
cls
echo .
echo About:
echo This script launchers a powershell script that allows you take files and search for a string and/or delimit them however you want.
echo .
echo Notes: In large files you will want to comment out the Write-Progress function with an "#" to increase performance
echo .
echo .
echo Instructions:
echo When prompted for filename: Enter a full file path or just a filename.ext (if it's in the same dir as the script)
echo When prompted (If you selected Option 1) enter the string you wish to search for to "grep" out everything else
echo When prompted for the existing delimiter; you can enter regex or a single delimeter that the data is using in the source file.
echo When prompted for the the replacement delimeter; enter character(s) such as a comma if you want a CSV ready file
echo .
echo .
echo .

SET /P ANSWER=Select (1) String search and delim (2) Just parse and delim the file (3) Exit (1 or 2 or 3)?
echo You chose: %ANSWER%
if /i {%ANSWER%}=={1} (goto :string)
if /i {%ANSWER%}=={2} (goto :delim)
if /i {%ANSWER%}=={2} (goto :exit)
goto :exit

:string
echo Starting up...
REM turns off script execution restrictions for Powershell
powershell.exe -executionpolicy unrestricted -command .\string_parse_delim.ps1
echo Press any key to exit...
pause
REM using /b with the exit parameters exits subroutine but not cmd.exe
exit /b 0

:delim
echo Starting up...
powershell.exe -executionpolicy unrestricted -command .\parse_delim.ps1
echo Press any key to exit...
pause
exit /b 1

:exit
echo Starting up...
echo Press any key to exit...
pause
exit /b 2
