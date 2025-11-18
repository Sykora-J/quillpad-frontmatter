# Building Quillpad - Quick Reference

## 📚 Documentation Files

This project includes comprehensive guides for building and deploying:

1. **`BUILD_AND_DEPLOY_GUIDE.md`** - Complete step-by-step guide with all details
2. **`QUICK_START_CHECKLIST.md`** - Quick checklist to verify your setup
3. **`README_BUILD.md`** - This file (quick reference)

## 🚀 Quick Start (TL;DR)

### Prerequisites
1. Install **Java JDK 11+** ([download](https://adoptium.net/))
2. Install **Android Studio** ([download](https://developer.android.com/studio))
3. Install **Android SDK Platform 35** (via Android Studio SDK Manager)

### Build & Install

**Option 1: Using Scripts (Easiest)**
```bash
# Linux/Mac
./build-and-install.sh

# Windows
build-and-install.bat
```

**Option 2: Using Android Studio**
1. Open project in Android Studio
2. Wait for Gradle sync
3. Click Run button (▶) or `Shift+F10`
4. Select your device

**Option 3: Command Line**
```bash
# Build
./gradlew assembleDebug  # Linux/Mac
gradlew.bat assembleDebug  # Windows

# Install
adb install app/build/outputs/apk/debug/app-debug.apk
```

## 📱 Phone Setup

1. Enable **Developer Options**: Settings → About Phone → Tap Build Number 7 times
2. Enable **USB Debugging**: Settings → Developer Options → USB Debugging ON
3. Connect phone via USB and authorize computer

## 🔍 Verify Setup

```bash
# Check Java
java -version  # Should be 11+

# Check ADB
adb devices  # Should show your device

# Check Android SDK (if ANDROID_HOME is set)
echo $ANDROID_HOME  # Linux/Mac
echo %ANDROID_HOME%  # Windows
```

## 📖 Full Documentation

For detailed instructions, troubleshooting, and explanations, see:
- **`BUILD_AND_DEPLOY_GUIDE.md`** - Complete guide with all steps

## 🆘 Need Help?

1. Check `BUILD_AND_DEPLOY_GUIDE.md` troubleshooting section
2. Verify all items in `QUICK_START_CHECKLIST.md`
3. Check Android Studio's build output for specific errors
4. Run `adb logcat` to see app logs if app crashes

## 📋 Project Info

- **Package**: `io.github.quillpad`
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: 35 (Android 15)
- **Language**: Kotlin
- **Build Tool**: Gradle 9.0.0

---

**Ready to build?** Start with `BUILD_AND_DEPLOY_GUIDE.md` for complete instructions!
