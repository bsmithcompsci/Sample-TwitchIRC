@echo off
echo Creating a CMake Solution...

call Clean.bat

if NOT EXIST ".Intermediate" (
    mkdir ".Intermediate"
)
if NOT EXIST ".Intermediate\Windows" (
    mkdir ".Intermediate/Windows"
)

CALL :NORMALIZEPATH "./ThirdParty/CMake/bin/cmake.exe"
set CMAKE="%RETVAL%"

echo | set /p=%VITALENGINE%>.Intermediate/Windows/enginedir.vitalbuild
pushd ".Intermediate/Windows"
%CMAKE% -G "Visual Studio 16 2019" -A x64 -DCMAKE_INSTALL_PREFIX:PATH="%~dp0\out\install" "%~dp0"
if NOT "%ERRORLEVEL%"=="0" (
    pause
)
popd

for %%f in (.Intermediate/Windows/*.sln) do (
    if "%%~xf"==".sln" (
        powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%~dp0\%%f.lnk');$s.TargetPath='%~dp0\.Intermediate\Windows\%%f';$s.Save()"
        goto eof
    )
)
:eof

:: ========== FUNCTIONS ==========

:NORMALIZEPATH
	SET RETVAL=%~f1
	EXIT /B