::
::  _win2posixPath_Utils.bat
::
::  Created by B.MOUFLIN on 29/12/2024
::  Copyright (c) 2024 BMOUFLIN. All rights reserved.
::
@echo off

:: Enable delayed expansion to handle dynamic variables
setlocal enabledelayedexpansion

rem === Windows path to POSIX path (or reversed) converter ===
rem Internal script

:: Arguments
:: Set to true to convert from POSIX path to Windows path
set reverzedConversion=%1
:: Display results in CMD window or not
set displayResults=%2
:: Set the output result to the clipboard or not
set setToClipboard=%3
:: Enable log
set logEnabled=%4

:: Local variables
set clipboardText=
set outputPath=

:: Get the current script path
set scriptpath=%~dp0
:: Set temporary file name
set "tempFile=%scriptpath%clipboard.log"
:: echo # Temp file path: %tempFile%   

:: Use PowerShell to get clipboard content and write to the temporary file
:: powershell -command "Get-Clipboard": This PowerShell command retrieves the current clipboard content.
:: Note: !clipboardText! runs with setlocal enabledelayedexpansion for accessing the updated value
powershell -NoProfile -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Clipboard" > "%tempFile%"
:: Loops through the output of the PowerShell command and assigns it to the clipboardText variable.
for /f "usebackq delims=" %%x in ("%tempFile%") do (
    set "clipboardText=!clipboardText!%%x"
)

:: Clean up the temporary file
del "%tempFile%"


if %logEnabled%==true (
	echo # Clipboard Content: !clipboardText!
)


:: Make the conversion
if %reverzedConversion%==false (
	if %logEnabled%==true (
		echo # Converting from  Windows to POSIX path
	)
	
	:: Replace backslashes with forward slashes using PowerShell (to handle special characters) and store the result in another variable
	for /f "usebackq delims=" %%y in (`powershell -NoProfile -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; '%clipboardText%' -replace '\\', '/'"`) do (
		set "outputPath=%%y"
	)

) else (
	if %logEnabled%==true (
		echo # Converting from POSIX to Windows path
	)
	
	:: Replace forward slashes with backslashes using PowerShell (to handle special characters) and store the result in another variable
	for /f "usebackq delims=" %%y in (`powershell -NoProfile -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; '%clipboardText%' -replace '/', '\'"`) do (
		set "outputPath=%%y"
	)

) 

if %setToClipboard%==true (
	:: Use PowerShell to copy the variable content to clipboard
	powershell -command "Set-Clipboard -Value '!outputPath!'"
)


if %displayResults%==true (
	:: Display the converted path
	echo !outputPath!


	:: END
	pause
)

:: End delayed expansion
endlocal