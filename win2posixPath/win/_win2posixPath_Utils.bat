::
::  _win2posixPath_Utils.bat
::
::  Created by B.MOUFLIN on 29/12/2024
::  Copyright (c) 2024 BMOUFLIN. All rights reserved.
::
@echo off
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

:: powershell -command "Get-Clipboard": This PowerShell command retrieves the current clipboard content.
:: Loops through the output of the PowerShell command and assigns it to the clipboardText variable.
:: Note: !clipboardText! runs with setlocal enabledelayedexpansion for accessing the updated value
for /f "delims=" %%x in ('powershell -command "Get-Clipboard"') do ( 
    set "clipboardText=!clipboardText!%%x"		
)

if %logEnabled%==true (
	echo # Clipboard Content: %clipboardText%
)


if %reverzedConversion%==false (
	if %logEnabled%==true (
		echo # Converting from  Windows to POSIX path
	)
	
	:: Replace backslashes with forward slashes
	set outputPath=%clipboardText:\=/%

) else (
	if %logEnabled%==true (
		echo # Converting from POSIX to Windows path
	)
	
	:: Replace forward slashes with backslashes
	set outputPath=%clipboardText:/=\%

) 

if %setToClipboard%==true (
	:: Use PowerShell to copy the variable content to clipboard
	powershell -command "Set-Clipboard -Value '!outputPath!'"
)


if %displayResults%==true (
	:: Display the converted path
	echo %outputPath%


	:: END
	pause
)
