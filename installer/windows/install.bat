@echo off
setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set PATCH_DIR=%SCRIPT_DIR%..\patch
set NGPACK=%SCRIPT_DIR%ngpack.exe

echo === Thimbleweed Park Korean Patch Installer (Windows) ===
echo.

if not exist "%NGPACK%" (
    echo Error: ngpack.exe was not found next to this script.
    echo See README.md for how to obtain or build it.
    pause
    exit /b 1
)

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
    if exist "!STEAM_DEFAULT!\ThimbleweedPark.ggpack1" (
        set "GAME_DIR=!STEAM_DEFAULT!"
        echo Auto-detected Steam install: !GAME_DIR!
    ) else if exist "!GOG_DEFAULT!\ThimbleweedPark.ggpack1" (
        set "GAME_DIR=!GOG_DEFAULT!"
        echo Auto-detected GOG install: !GAME_DIR!
    ) else (
        echo Error: could not auto-detect the game folder. Run this script again and enter the path manually.
        pause
        exit /b 1
    )
)

set "GGPACK=!GAME_DIR!\ThimbleweedPark.ggpack1"
set "BACKUP=!GAME_DIR!\ThimbleweedPark.ggpack1.orig"

if not exist "%GGPACK%" (
    echo Error: "%GGPACK%" not found. Check the path.
    pause
    exit /b 1
)

if not exist "%BACKUP%" (
    echo Backing up original ggpack1...
    copy "%GGPACK%" "%BACKUP%" >nul
) else (
    echo An existing backup was found, reusing it as the source.
)

set WORKDIR=%TEMP%\twp_ko_%RANDOM%
mkdir "%WORKDIR%"
copy "%BACKUP%" "%WORKDIR%\ThimbleweedPark.ggpack1" >nul

pushd "%WORKDIR%"

echo Extracting game files...
"%NGPACK%" extract ThimbleweedPark.ggpack1 -p "*"
del ThimbleweedPark.ggpack1

echo Applying Korean translation files...
xcopy "%PATCH_DIR%" . /E /Y /I >nul

echo Repacking...
"%NGPACK%" create ThimbleweedPark.ggpack1 -k auto -p "*"

popd

echo Replacing game file...
copy "%WORKDIR%\ThimbleweedPark.ggpack1" "%GGPACK%" >nul

rmdir /s /q "%WORKDIR%"

echo.
echo Installation complete!
echo In-game: Options ^> Language, then pick "Korean Text" from the list to see the Korean text.
echo (It replaces the entry that used to say "German Text".)
pause
