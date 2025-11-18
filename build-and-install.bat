@echo off
REM Quillpad Build and Install Script for Windows
REM This script builds the debug APK and installs it on a connected Android device

echo.
echo 🚀 Quillpad Build and Install Script
echo ======================================
echo.

REM Check if ADB is available
where adb >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Error: ADB not found. Please install Android SDK Platform-Tools.
    echo    Or add it to your PATH: set PATH=%%PATH%%;%%ANDROID_HOME%%\platform-tools
    exit /b 1
)

REM Check if device is connected
echo 📱 Checking for connected devices...
adb devices | findstr /C:"device$" >nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Error: No Android device found.
    echo    Please:
    echo    1. Connect your phone via USB
    echo    2. Enable USB Debugging in Developer Options
    echo    3. Authorize this computer on your phone
    echo.
    echo    Run 'adb devices' to verify connection
    exit /b 1
)

echo ✅ Found device(s)
echo.

REM Check if Java is available
where java >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Error: Java not found. Please install JDK 11 or higher.
    exit /b 1
)

echo ✅ Java found
echo.

REM Clean previous build
echo 🧹 Cleaning previous build...
call gradlew.bat clean
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Clean failed
    exit /b 1
)

REM Build debug APK
echo.
echo 🔨 Building debug APK...
call gradlew.bat assembleDebug
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Build failed
    exit /b 1
)

REM Check if APK was created
set APK_PATH=app\build\outputs\apk\debug\app-debug.apk
if not exist "%APK_PATH%" (
    echo ❌ Error: APK not found at %APK_PATH%
    exit /b 1
)

echo ✅ APK built successfully
echo.

REM Uninstall existing app (ignore errors if not installed)
echo 🗑️  Uninstalling existing app (if present)...
adb uninstall io.github.quillpad >nul 2>&1

REM Install APK
echo.
echo 📲 Installing APK on device...
adb install -r "%APK_PATH%"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Installation failed. Check the error messages above.
    exit /b 1
)

echo.
echo ✅ Installation successful!
echo.
echo 🎉 Quillpad is now installed on your device!
echo.
echo To launch the app, run:
echo    adb shell am start -n io.github.quillpad/.MainActivity
echo.
echo Or simply open it from your app drawer.
echo.
