@echo off

:: Kill all Visual Studio environments, because they can limit file deletion.
tasklist /FI "IMAGENAME eq devenv.exe" 2>NUL | find /I /N "devenv.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /f /im devenv.exe /t

:: Cleanup old CMake files.
if EXIST ".Intermediate\Windows" (
    rd /s /q ".Intermediate\Windows"
)

:: Cleanup any links/shortcuts
for %%f in (*.sln.lnk) do (
    del /q %~dp0\%%f
)

:eof