@echo off
setlocal
cd /d "%~dp0"

where gcc >nul 2>nul
if errorlevel 1 (
    echo gcc was not found. Install a C compiler first, for example:
    echo     winget install BrechtSanders.WinLibs.POSIX.UCRT
    echo Then close this window, open a new one and run build.bat again.
    pause
    exit /b 1
)

set RES=
where windres >nul 2>nul
if not errorlevel 1 (
    windres voxcraft.rc -O coff -o voxcraft_res.o >nul 2>nul
    if exist voxcraft_res.o set RES=voxcraft_res.o
)

echo Compiling VoxCraft...
gcc voxcraft.c %RES% -o voxcraft.exe -O2 -s -mwindows -lopengl32 -lgdi32 -luser32 -lm
if errorlevel 1 (
    echo.
    echo Build failed. Copy the error text above and send it back so it can be fixed.
    pause
    exit /b 1
)

echo Build OK - starting VoxCraft...
start "" voxcraft.exe
