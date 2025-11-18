#!/bin/bash

# Environment Check Script for Quillpad
# Verifies that all required tools and dependencies are installed

echo "🔍 Checking Quillpad Build Environment"
echo "======================================"
echo ""

ERRORS=0
WARNINGS=0

# Check Java
echo -n "Checking Java... "
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)
    MAJOR_VERSION=$(echo $JAVA_VERSION | cut -d'.' -f1)
    if [ "$MAJOR_VERSION" -ge 11 ]; then
        echo "✅ Found Java $JAVA_VERSION"
    else
        echo "❌ Java 11+ required. Found Java $JAVA_VERSION"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "❌ Java not found. Please install JDK 11 or higher."
    ERRORS=$((ERRORS + 1))
fi

# Check Android SDK / ADB
echo -n "Checking ADB... "
if command -v adb &> /dev/null; then
    ADB_VERSION=$(adb version | head -n 1)
    echo "✅ Found $ADB_VERSION"
else
    echo "⚠️  ADB not found in PATH"
    echo "   (Optional - only needed for direct installation)"
    WARNINGS=$((WARNINGS + 1))
fi

# Check ANDROID_HOME
echo -n "Checking ANDROID_HOME... "
if [ -n "$ANDROID_HOME" ]; then
    if [ -d "$ANDROID_HOME" ]; then
        echo "✅ Set to $ANDROID_HOME"
        
        # Check for SDK Platform 35
        if [ -d "$ANDROID_HOME/platforms/android-35" ]; then
            echo "   ✅ Android SDK Platform 35 installed"
        else
            echo "   ⚠️  Android SDK Platform 35 not found"
            echo "      Install via Android Studio: SDK Manager → SDK Platforms → Android 15.0 (API 35)"
            WARNINGS=$((WARNINGS + 1))
        fi
        
        # Check for build-tools
        if [ -d "$ANDROID_HOME/build-tools" ]; then
            BUILD_TOOLS=$(ls "$ANDROID_HOME/build-tools" | head -n 1)
            echo "   ✅ Android Build-Tools found ($BUILD_TOOLS)"
        else
            echo "   ⚠️  Android Build-Tools not found"
            WARNINGS=$((WARNINGS + 1))
        fi
    else
        echo "⚠️  ANDROID_HOME set but directory doesn't exist: $ANDROID_HOME"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo "⚠️  ANDROID_HOME not set (optional but recommended)"
    WARNINGS=$((WARNINGS + 1))
fi

# Check Gradle
echo -n "Checking Gradle Wrapper... "
if [ -f "gradlew" ]; then
    echo "✅ Found"
    chmod +x gradlew 2>/dev/null
else
    echo "❌ gradlew not found. Are you in the project root?"
    ERRORS=$((ERRORS + 1))
fi

# Check if Android Studio might be installed (heuristic)
echo -n "Checking for Android Studio... "
if [ -d "$HOME/Android" ] || [ -d "$HOME/.android" ] || command -v studio.sh &> /dev/null 2>&1 || [ -d "/Applications/Android Studio.app" ] 2>/dev/null || [ -d "$HOME/AppData/Local/Android" ] 2>/dev/null; then
    echo "✅ Android Studio likely installed"
else
    echo "⚠️  Android Studio not detected (may still be installed elsewhere)"
    WARNINGS=$((WARNINGS + 1))
fi

# Check connected devices
if command -v adb &> /dev/null; then
    echo -n "Checking for connected devices... "
    DEVICES=$(adb devices 2>/dev/null | grep -v "List" | grep "device$" | wc -l)
    if [ "$DEVICES" -gt 0 ]; then
        echo "✅ $DEVICES device(s) connected"
    else
        echo "⚠️  No devices connected (connect phone for direct installation)"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# Check disk space (at least 5GB free recommended)
echo -n "Checking disk space... "
if command -v df &> /dev/null; then
    AVAILABLE=$(df -BG . | tail -n 1 | awk '{print $4}' | sed 's/G//')
    if [ "$AVAILABLE" -ge 5 ]; then
        echo "✅ ${AVAILABLE}GB available"
    else
        echo "⚠️  Only ${AVAILABLE}GB available (5GB+ recommended)"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo "⚠️  Could not check disk space"
    WARNINGS=$((WARNINGS + 1))
fi

# Summary
echo ""
echo "======================================"
echo "Summary"
echo "======================================"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "✅ All checks passed! You're ready to build."
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo "⚠️  $WARNINGS warning(s) found, but you can still try building."
    echo "   Review warnings above and see BUILD_AND_DEPLOY_GUIDE.md for details."
    exit 0
else
    echo "❌ $ERRORS error(s) found. Please fix these before building:"
    echo ""
    echo "1. Install missing required tools (Java, Android SDK)"
    echo "2. See BUILD_AND_DEPLOY_GUIDE.md for installation instructions"
    exit 1
fi
