@echo off
setlocal enabledelayedexpansion

echo === Thimbleweed Park Korean Patch Uninstaller (Windows) ===
echo.
echo Example paths:
echo   Steam: C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park
echo   GOG:   C:\GOG Games\Thimbleweed Park
echo.

set "STEAM_DEFAULT=C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park"
set "GOG_DEFAULT=C:\GOG Games\Thimbleweed Park"

if "%~1"=="" (
    set /p GAME_DIR="Enter the game folder path (press Enter to auto-detect Steam/GOG): "
) else (
    set "GAME_DIR=%~1"
)

if "!GAME_DIR!"=="" (
    if exist "!STEAM_DEFAULT!\ThimbleweedPark.ggpack1.orig" (
        set "GAME_DIR=!STEAM_DEFAULT!"
        echo Auto-detected Steam install: !GAME_DIR!
    ) else if exist "!GOG_DEFAULT!\ThimbleweedPark.ggpack1.orig" (
        set "GAME_DIR=!GOG_DEFAULT!"
        echo Auto-detected GOG install: !GAME_DIR!
    ) else (
        echo Error: could not auto-detect a backup in the default folders. Run this script again and enter the path manually.
        pause
        exit /b 1
    )
)

set "GGPACK=!GAME_DIR!\ThimbleweedPark.ggpack1"
set "BACKUP=!GAME_DIR!\ThimbleweedPark.ggpack1.orig"

if not exist "%BACKUP%" (
    echo Error: backup file not found at "%BACKUP%".
    echo The patch may not be installed, or it was already removed.
    pause
    exit /b 1
)

copy "%BACKUP%" "%GGPACK%" >nul
echo Restored the original ggpack1.
pause
