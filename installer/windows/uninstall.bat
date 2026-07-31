@echo off
setlocal enabledelayedexpansion

echo === Thimbleweed Park Korean Patch Uninstaller (Windows) ===
echo.

if "%~1"=="" (
    set /p GAME_DIR="Enter the game folder path: "
) else (
    set GAME_DIR=%~1
)

set GGPACK=%GAME_DIR%\ThimbleweedPark.ggpack1
set BACKUP=%GAME_DIR%\ThimbleweedPark.ggpack1.orig

if not exist "%BACKUP%" (
    echo Error: backup file not found at "%BACKUP%".
    echo The patch may not be installed, or it was already removed.
    pause
    exit /b 1
)

copy "%BACKUP%" "%GGPACK%" >nul
echo Restored the original ggpack1.
pause
