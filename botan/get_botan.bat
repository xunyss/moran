@echo off
setlocal

:: check if parameter is provided
if "%~1"=="" (
    echo [get_botan] Usage: %0 ^<botan_build_directory^>
    exit /b 1
)

:: check if version.txt exists
if not exist "version.txt" (
    echo [get_botan] Error: version.txt file not found!
    exit /b 1
)

:: check if botan_build_directory exists
if exist "%~1" (
    echo [get_botan] directory '%~1' already exists
    echo [get_botan] build botan library at '%~1'
    exit /b 0
)


:: get version from version.txt
set /p BOTAN_VERSION=<version.txt
:: remove spaces from version
set BOTAN_VERSION=%BOTAN_VERSION: =%
set BOTAN_FILE=Botan-%BOTAN_VERSION%.tar.xz


:: check if botan_release exists / download botan_release
if not exist "%BOTAN_FILE%" (
    echo [get_botan] Downloading %BOTAN_FILE% ...
    curl -O "https://botan.randombit.net/releases/%BOTAN_FILE%"
    if errorlevel 1 (
        echo [get_botan] Error: Failed to download file
        exit /b 1
    )
) else (
    echo [get_botan] %BOTAN_FILE% already exists
)

:: create temp directory
set TEMP_DIR=%TEMP%\botan_%RANDOM%
mkdir "%TEMP_DIR%"
if errorlevel 1 (
    echo [get_botan] Error: Failed to create temp directory
    exit /b 1
)

:: extract tar file
echo [get_botan] extracting %BOTAN_FILE%
tar -xf "%BOTAN_FILE%" -C "%TEMP_DIR%"
@REM symbolic link error occurred. if 'configure.py' file exists, it's considered success.
@REM if errorlevel 1 (
@REM     echo [get_botan] Error: Failed to extract file
@REM     rd /s /q "%TEMP_DIR%"
@REM     exit /b 1
@REM )
if not exist "%TEMP_DIR%\Botan-%BOTAN_VERSION%\configure.py" (
    echo [get_botan] Error: Failed to extract file
    rd /s /q "%TEMP_DIR%"
    exit /b 1
)
move "%TEMP_DIR%\Botan-%BOTAN_VERSION%" "%~1"
if errorlevel 1 (
    echo [get_botan] Error: Failed to move directory
    rd /s /q "%TEMP_DIR%"
    exit /b 1
)

:: cleanup temp directory
rd /s /q "%TEMP_DIR%"

:: message
echo [get_botan] build botan library at '%~1'

endlocal

