::
::  posix2winPath_CLIPBOARD-DISPLAY.bat
::
::  Created by B.MOUFLIN on 29/12/2024
::  Copyright (c) 2024 BMOUFLIN. All rights reserved.
::
@echo off

rem === POSIX path to Windows path converter ===
rem Set result to Clipboard AND display in CMD window

:: Set to true to convert from POSIX path to Windows path
set reverzedConversion=true
:: Display results in CMD window or not
set displayResults=true
:: Set the output result to the clipboard or not
set setToClipboard=true
:: Enable log
set logEnabled=false


if %logEnabled%==true (
	echo # Start path conversion:
)


:: Call _win2posixPath_Utils.bat and pass the arguments
call _win2posixPath_Utils.bat %reverzedConversion% %displayResults% %setToClipboard% %logEnabled%


if %logEnabled%==true (
	echo # Finshed path conversion.

	:: END
	pause
)
