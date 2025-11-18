@echo off
REM Environment Check Script for Quillpad (Windows)
REM Verifies that all required tools and dependencies are installed

echo.
echo 🔍 Checking Quillpad Build Environment
echo ======================================
echo.

set ERRORS=0
set WARNINGS=0

REM Check Java
echo Checking Java...
where java >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✅ Java found
    java -version 2>&1 | findstr /C:"version"
) else (
    echo ❌ Java not found. Please install JDK 11 or higher.
    set /a ERRORS+=1
)

echo.

REM Check ADB
echo Checking ADB...
where adb >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✅ ADB found
    adb version | findstr "Version"
) else (
    echo ⚠️  ADB not found in PATH (optional - only needed for direct installation)
    set /a WARNINGS+=1
)

echo.

REM Check ANDROID_HOME
echo Checking ANDROID_HOME...
if defined ANDROID_HOME (
    if exist "%ANDROID_HOME%" (
        echo ✅ Set to %ANDROID_HOME%
        
        REM Check for SDK Platform 35
        if exist "%ANDROID_HOME%\platforms\android-35" (
            echo    ✅ Android SDK Platform 35 installed
        ) else (
            echo    ⚠️  Android SDK Platform 35 not found
            echo       Install via Android Studio: SDK Manager → SDK Platforms → Android 15.0 (API 35)
            set /a WARNINGS+=1
        )
        
        REM Check for build-tools
        if exist "%ANDROID_HOME%\build-tools" (
            echo    ✅ Android Build-Tools found
        ) else (
            echo    ⚠️  Android Build-Tools not found
            set /a WARNINGS+=1
        )
    ) else (
        echo ⚠️  ANDROID_HOME set but directory doesn't exist: %ANDROID_HOME%
        set /a WARNINGS+=1
    )
) else (
    echo ⚠️  ANDROID_HOME not set (optional but recommended)
    set /a WARNINGS+=1
)

echo.

REM Check Gradle Wrapper
echo Checking Gradle Wrapper...
if exist "gradlew.bat" (
    echo ✅ Found
) else (
    echo ❌ gradlew.bat not found. Are you in the project root?
    set /a ERRORS+=1
)

echo.

REM Check for Android Studio
echo Checking for Android Studio...
if exist "%LOCALAPPDATA%\Android" (
    echo ✅ Android Studio likely installed
) else (
    echo ⚠️  Android Studio not detected (may still be installed elsewhere)
    set /a WARNINGS+=1
)

echo.

REM Check connected devices
where adb >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Checking for connected devices...
    adb devices | findstr /C:"device$" >nul
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Device(s) connected
    ) else (
        echo ⚠️  No devices connected (connect phone for direct installation)
        set /a WARNINGS+=1
    )
)

echo.
echo ======================================
echo Summary
echo ======================================
if %ERRORS% EQU 0 if %WARNINGS% EQU 0 (
    echo ✅ All checks passed! You're ready to build.
    exit /b 0
) else if %ERRORS% EQU 0 (
    echo ⚠️  %WARNINGS% warning(s) found, but you can still try building.
    echo    Review warnings above and see BUILD_AND_DEPLOY_GUIDE.md for details.
    exit /b 0
) else (
    echo ❌ %ERRORS% error(s) found. Please fix these before building:
    echo.
    echo 1. Install missing required tools (Java, Android SDK)
    echo 2. See BUILD_AND_DEPLOY_GUIDE.md for installation instructions
    exit /b 1
)
