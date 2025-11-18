# Quick Start Checklist

Use this checklist to ensure you have everything set up correctly.

## ✅ Prerequisites Checklist

- [ ] **Java JDK 11+ installed**
  - Check: `java -version` shows version 11 or higher
  - If not: Download from [adoptium.net](https://adoptium.net/)

- [ ] **Android Studio installed**
  - Download from [developer.android.com/studio](https://developer.android.com/studio)
  - First launch completed and SDK components downloaded

- [ ] **Android SDK Platform 35 installed**
  - Check in Android Studio: `File` → `Settings` → `Android SDK`
  - Or check: `$ANDROID_HOME/platforms/android-35` exists

- [ ] **Android SDK Build-Tools installed**
  - Check in Android Studio: `File` → `Settings` → `Android SDK`
  - Or check: `$ANDROID_HOME/build-tools` contains version folder

- [ ] **Android SDK Platform-Tools installed** (includes ADB)
  - Check: `adb version` works in terminal
  - Location: `$ANDROID_HOME/platform-tools/adb`

- [ ] **Environment Variables Set** (Optional but recommended)
  - `ANDROID_HOME` points to SDK location
  - `PATH` includes `$ANDROID_HOME/platform-tools`

## ✅ Project Setup Checklist

- [ ] **Project opened in Android Studio**
  - `File` → `Open` → Select project folder

- [ ] **Gradle sync completed successfully**
  - No red error messages in build output
  - Dependencies downloaded (check `~/.gradle/caches`)

- [ ] **No build errors**
  - `Build` → `Clean Project` → `Rebuild Project`
  - Check for any red error indicators

## ✅ Phone Setup Checklist (For USB Debugging)

- [ ] **Developer Options enabled**
  - `Settings` → `About Phone` → Tap `Build Number` 7 times

- [ ] **USB Debugging enabled**
  - `Settings` → `Developer Options` → `USB Debugging` ON

- [ ] **Phone connected via USB**
  - USB cable connected
  - Phone shows "USB debugging connected" notification

- [ ] **ADB recognizes device**
  - Run: `adb devices`
  - Should show: `[device-id]    device` (not "unauthorized")

- [ ] **Authorized computer**
  - Phone prompted "Allow USB debugging?"
  - Checked "Always allow from this computer"
  - Tapped "OK"

## ✅ Build Checklist

- [ ] **Debug APK built successfully**
  - `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
  - File exists: `app/build/outputs/apk/debug/app-debug.apk`

- [ ] **APK size reasonable** (should be 10-50 MB)
  - If much larger, check for unnecessary assets

## ✅ Installation Checklist

- [ ] **App installed on phone**
  - Via Android Studio: Click Run button (▶)
  - Via ADB: `adb install app/build/outputs/apk/debug/app-debug.apk`
  - Via APK: Transfer file and tap to install

- [ ] **App launches successfully**
  - App icon appears on phone
  - App opens without crashing
  - Can navigate through app

## 🚨 Common Issues Quick Fix

| Issue | Quick Fix |
|-------|-----------|
| Gradle sync fails | `File` → `Invalidate Caches / Restart` |
| ADB device not found | Check USB cable, try different port, re-enable USB debugging |
| Build out of memory | Increase in `gradle.properties`: `org.gradle.jvmargs=-Xmx4096m` |
| SDK not found | Install SDK Platform 35 in Android Studio SDK Manager |
| Installation blocked | Enable "Install Unknown Apps" in phone settings |
| App crashes on launch | Check `adb logcat` for error messages |

## 📱 Minimum Requirements

- **Phone**: Android 7.0 (API 24) or higher
- **Computer RAM**: 8GB minimum, 16GB recommended
- **Disk Space**: 10GB free for Android Studio + SDK
- **Internet**: Required for downloading dependencies

## 🎯 Next Steps After Installation

1. Test basic functionality
2. Check app logs: `adb logcat | grep quillpad`
3. Make code changes and rebuild
4. Test on different Android versions if possible

---

**All checked?** You're ready to develop! 🚀
