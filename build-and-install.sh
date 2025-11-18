#!/bin/bash

# Quillpad Build and Install Script
# This script builds the debug APK and installs it on a connected Android device

set -e  # Exit on error

echo "🚀 Quillpad Build and Install Script"
echo "======================================"
echo ""

# Check if ADB is available
if ! command -v adb &> /dev/null; then
    echo "❌ Error: ADB not found. Please install Android SDK Platform-Tools."
    echo "   Or add it to your PATH: export PATH=\$PATH:\$ANDROID_HOME/platform-tools"
    exit 1
fi

# Check if device is connected
echo "📱 Checking for connected devices..."
DEVICES=$(adb devices | grep -v "List" | grep "device$" | wc -l)

if [ "$DEVICES" -eq 0 ]; then
    echo "❌ Error: No Android device found."
    echo "   Please:"
    echo "   1. Connect your phone via USB"
    echo "   2. Enable USB Debugging in Developer Options"
    echo "   3. Authorize this computer on your phone"
    echo ""
    echo "   Run 'adb devices' to verify connection"
    exit 1
fi

echo "✅ Found $DEVICES device(s)"
echo ""

# Check if Java is available
if ! command -v java &> /dev/null; then
    echo "❌ Error: Java not found. Please install JDK 11 or higher."
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 11 ]; then
    echo "❌ Error: Java 11 or higher required. Found Java $JAVA_VERSION"
    exit 1
fi

echo "✅ Java version OK"
echo ""

# Make gradlew executable
chmod +x gradlew

# Clean previous build
echo "🧹 Cleaning previous build..."
./gradlew clean

# Build debug APK
echo ""
echo "🔨 Building debug APK..."
./gradlew assembleDebug

# Check if APK was created
APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
if [ ! -f "$APK_PATH" ]; then
    echo "❌ Error: APK not found at $APK_PATH"
    exit 1
fi

APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
echo "✅ APK built successfully ($APK_SIZE)"
echo ""

# Uninstall existing app (ignore errors if not installed)
echo "🗑️  Uninstalling existing app (if present)..."
adb uninstall io.github.quillpad 2>/dev/null || true

# Install APK
echo ""
echo "📲 Installing APK on device..."
adb install -r "$APK_PATH"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Installation successful!"
    echo ""
    echo "🎉 Quillpad is now installed on your device!"
    echo ""
    echo "To launch the app, run:"
    echo "   adb shell am start -n io.github.quillpad/.MainActivity"
    echo ""
    echo "Or simply open it from your app drawer."
else
    echo ""
    echo "❌ Installation failed. Check the error messages above."
    exit 1
fi
