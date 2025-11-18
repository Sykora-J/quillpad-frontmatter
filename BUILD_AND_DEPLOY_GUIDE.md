# Complete Guide: Building and Deploying Quillpad to Your Phone

This guide will walk you through every step needed to go from source code to a working app on your Android phone.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation Steps](#installation-steps)
3. [Setting Up Your Phone](#setting-up-your-phone)
4. [Building the App](#building-the-app)
5. [Deploying to Your Phone](#deploying-to-your-phone)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software

#### 1. **Java Development Kit (JDK) 11 or higher**
   - **Why**: Android development requires Java/Kotlin compilation
   - **Download**: 
     - **Windows/Mac/Linux**: [Oracle JDK 11+](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK 11+](https://adoptium.net/)
     - **Linux (Ubuntu/Debian)**: `sudo apt-get install openjdk-11-jdk`
     - **macOS (Homebrew)**: `brew install openjdk@11`
   - **Verify installation**: Open terminal/command prompt and run:
     ```bash
     java -version
     ```
     You should see version 11 or higher.

#### 2. **Android Studio** (Recommended) or Command Line Tools
   - **Why**: Android Studio includes everything you need (SDK, emulator, build tools)
   - **Download**: [https://developer.android.com/studio](https://developer.android.com/studio)
   - **Minimum version**: Android Studio Hedgehog (2023.1.1) or newer
   - **Size**: ~1GB download, ~3GB after installation
   - **Alternative**: If you prefer command line, install Android SDK Command Line Tools

#### 3. **Android SDK**
   - **Included with Android Studio**: If you install Android Studio, SDK comes with it
   - **Standalone**: Download from [Android Developer Site](https://developer.android.com/studio#command-tools)
   - **Required components**:
     - Android SDK Platform 35 (compileSdk)
     - Android SDK Build-Tools
     - Android SDK Platform-Tools (includes ADB)
     - Android Emulator (optional, for testing)

#### 4. **Git** (if not already installed)
   - **Why**: To clone/download the project
   - **Download**: [https://git-scm.com/downloads](https://git-scm.com/downloads)
   - **Verify**: `git --version`

---

## Installation Steps

### Step 1: Install Android Studio

1. **Download Android Studio**
   - Go to [https://developer.android.com/studio](https://developer.android.com/studio)
   - Click "Download Android Studio"
   - Choose your operating system (Windows/Mac/Linux)

2. **Install Android Studio**
   - **Windows**: Run the `.exe` installer, follow the wizard
   - **Mac**: Open the `.dmg`, drag Android Studio to Applications
   - **Linux**: Extract the `.tar.gz` and run `bin/studio.sh`

3. **First Launch Setup**
   - Launch Android Studio
   - Choose "Standard" installation type
   - Accept licenses when prompted
   - Let it download SDK components (this takes 10-30 minutes)
   - **Important**: Make sure SDK Platform 35 is installed

### Step 2: Verify Android SDK Installation

1. **In Android Studio**:
   - Go to `File` → `Settings` (or `Android Studio` → `Preferences` on Mac)
   - Navigate to `Appearance & Behavior` → `System Settings` → `Android SDK`
   - Check that **Android 15.0 (API Level 35)** is installed
   - Check that **Android SDK Build-Tools** is installed
   - Check that **Android SDK Platform-Tools** is installed

2. **Set Environment Variables** (Optional but recommended):
   
   **Windows**:
   - Open System Properties → Environment Variables
   - Add new variable:
     - Variable: `ANDROID_HOME`
     - Value: `C:\Users\YourUsername\AppData\Local\Android\Sdk` (or your SDK path)
   - Add to PATH: `%ANDROID_HOME%\platform-tools` and `%ANDROID_HOME%\tools`
   
   **Linux/Mac**:
   - Add to `~/.bashrc` or `~/.zshrc`:
     ```bash
     export ANDROID_HOME=$HOME/Android/Sdk
     export PATH=$PATH:$ANDROID_HOME/platform-tools
     export PATH=$PATH:$ANDROID_HOME/tools
     ```
   - Then run: `source ~/.bashrc` (or `source ~/.zshrc`)

### Step 3: Open the Project

1. **If you have the code locally**:
   - Open Android Studio
   - Click `File` → `Open`
   - Navigate to the project folder (where `build.gradle.kts` is located)
   - Click `OK`

2. **If you need to clone the repository**:
   ```bash
   git clone <repository-url>
   cd quillpad
   ```
   Then open the folder in Android Studio as above.

3. **Sync Gradle**:
   - Android Studio will automatically prompt to sync Gradle
   - Click "Sync Now" if prompted
   - Wait for dependencies to download (first time takes 5-15 minutes)
   - If sync fails, see [Troubleshooting](#troubleshooting)

---

## Setting Up Your Phone

### Option A: USB Debugging (Recommended for Development)

1. **Enable Developer Options**:
   - Go to `Settings` → `About Phone`
   - Find `Build Number` (may be under `Software Information`)
   - Tap `Build Number` **7 times** until you see "You are now a developer!"

2. **Enable USB Debugging**:
   - Go back to `Settings` → `Developer Options` (now visible)
   - Enable `USB Debugging`
   - Enable `Install via USB` (if available)

3. **Connect Your Phone**:
   - Connect phone to computer via USB cable
   - On your phone, you'll see a prompt: "Allow USB debugging?"
   - Check "Always allow from this computer" and tap "OK"

4. **Verify Connection**:
   - Open terminal/command prompt
   - Run: `adb devices`
   - You should see your device listed (e.g., `ABC123XYZ    device`)

### Option B: Build APK and Install Manually

If you prefer not to use USB debugging, you can build an APK file and transfer it to your phone.

**Requirements**:
- Your phone must allow installation from "Unknown Sources"
- Go to `Settings` → `Security` → Enable `Install Unknown Apps` (or `Install from Unknown Sources`)

---

## Building the App

### Method 1: Using Android Studio (Easiest)

1. **Open the Project** (if not already open)
   - File → Open → Select project folder

2. **Wait for Gradle Sync**
   - Bottom right corner will show "Gradle sync in progress..."
   - Wait until it completes (may take several minutes first time)

3. **Build Debug APK**:
   - Click `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
   - Wait for build to complete (2-5 minutes first time)
   - When done, click "locate" in the notification, or find it at:
     ```
     app/build/outputs/apk/debug/app-debug.apk
     ```

4. **Build Release APK** (Optional - for production):
   - Click `Build` → `Generate Signed Bundle / APK`
   - Select `APK` → `Next`
   - **First time**: Create a keystore:
     - Click `Create new...`
     - Fill in keystore details (save password securely!)
     - Click `OK`
   - Select your keystore → Enter passwords → `Next`
   - Select `release` build variant → `Finish`
   - APK will be at: `app/build/outputs/apk/release/app-release.apk`

### Method 2: Using Command Line

1. **Navigate to Project Directory**:
   ```bash
   cd /path/to/quillpad
   ```

2. **Make Gradle Wrapper Executable** (Linux/Mac):
   ```bash
   chmod +x gradlew
   ```

3. **Build Debug APK**:
   ```bash
   # Windows
   gradlew.bat assembleDebug
   
   # Linux/Mac
   ./gradlew assembleDebug
   ```

4. **Find the APK**:
   ```
   app/build/outputs/apk/debug/app-debug.apk
   ```

5. **Build Release APK** (requires signing configuration):
   ```bash
   # Windows
   gradlew.bat assembleRelease
   
   # Linux/Mac
   ./gradlew assembleRelease
   ```

---

## Deploying to Your Phone

### Method 1: Direct Install via USB (Fastest)

1. **Connect Phone** (see [Setting Up Your Phone](#setting-up-your-phone))

2. **Verify Connection**:
   ```bash
   adb devices
   ```
   Should show your device.

3. **Install via Android Studio**:
   - Click the green "Run" button (▶) or press `Shift+F10`
   - Select your connected device from the list
   - Click `OK`
   - App will build and install automatically

4. **Install via Command Line**:
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```
   If app already exists, use:
   ```bash
   adb install -r app/build/outputs/apk/debug/app-debug.apk
   ```

### Method 2: Transfer APK to Phone

1. **Build APK** (see [Building the App](#building-the-app))

2. **Transfer APK**:
   - **Via USB**: Copy `app-debug.apk` to your phone's storage
   - **Via Email**: Email the APK to yourself, open on phone
   - **Via Cloud**: Upload to Google Drive/Dropbox, download on phone
   - **Via ADB**: `adb push app/build/outputs/apk/debug/app-debug.apk /sdcard/Download/`

3. **Install on Phone**:
   - Open `Files` app on your phone
   - Navigate to where you saved the APK
   - Tap the APK file
   - Tap "Install"
   - If prompted about "Unknown Sources", tap "Settings" and enable it
   - Tap "Install" again
   - Tap "Open" when installation completes

---

## Troubleshooting

### Gradle Sync Fails

**Problem**: "Failed to sync Gradle project"

**Solutions**:
1. **Check Internet Connection**: Gradle needs to download dependencies
2. **Check JDK Version**: 
   ```bash
   java -version  # Should be 11 or higher
   ```
3. **Invalidate Caches**: 
   - Android Studio → `File` → `Invalidate Caches / Restart`
4. **Check Gradle Wrapper**: 
   - File → `Settings` → `Build, Execution, Deployment` → `Gradle`
   - Use Gradle from: `gradle-wrapper.properties` file
5. **Manual Gradle Sync**: 
   - Click `File` → `Sync Project with Gradle Files`

### Build Fails

**Problem**: "Build failed" or compilation errors

**Solutions**:
1. **Clean Project**: 
   - `Build` → `Clean Project`
   - Then `Build` → `Rebuild Project`
2. **Check SDK Version**: Ensure Android SDK Platform 35 is installed
3. **Check Dependencies**: Ensure all repositories are accessible (check internet)
4. **Check Kotlin Version**: Project uses Kotlin 2.2.0 - ensure compatibility

### ADB Not Recognizing Device

**Problem**: `adb devices` shows nothing or "unauthorized"

**Solutions**:
1. **Check USB Connection**: Try different USB cable/port
2. **Check USB Mode**: Phone should be in "File Transfer" or "MTP" mode
3. **Revoke USB Debugging**: 
   - On phone: `Settings` → `Developer Options` → `Revoke USB debugging authorizations`
   - Reconnect and authorize again
4. **Install USB Drivers** (Windows):
   - Download from phone manufacturer's website
   - Or use [Universal ADB Drivers](https://adb.clockworkmod.com/)

### "Installation Failed" on Phone

**Problem**: Can't install APK on phone

**Solutions**:
1. **Enable Unknown Sources**: 
   - `Settings` → `Security` → `Install Unknown Apps` → Enable for your file manager
2. **Check Storage Space**: Ensure phone has enough storage
3. **Uninstall Old Version**: If app exists, uninstall it first
4. **Check Android Version**: App requires Android 7.0 (API 24) or higher

### Out of Memory During Build

**Problem**: "OutOfMemoryError" or build crashes

**Solutions**:
1. **Increase Gradle Memory**:
   - Create/edit `gradle.properties` in project root:
     ```
     org.gradle.jvmargs=-Xmx2048m -XX:MaxMetaspaceSize=512m
     ```
2. **Close Other Applications**: Free up RAM
3. **Use 64-bit JDK**: Ensure you're using 64-bit Java

### Missing SDK Components

**Problem**: "SDK platform not found" or similar

**Solutions**:
1. **Install Missing Components**:
   - Android Studio → `Tools` → `SDK Manager`
   - Check `Android SDK Platform 35`
   - Check `Android SDK Build-Tools`
   - Click `Apply` to install
2. **Check SDK Path**: Ensure `ANDROID_HOME` is set correctly

---

## Quick Reference Commands

```bash
# Check Java version
java -version

# Check ADB connection
adb devices

# Install APK
adb install app/build/outputs/apk/debug/app-debug.apk

# Uninstall app
adb uninstall io.github.quillpad

# View logcat (app logs)
adb logcat

# Build debug APK (Linux/Mac)
./gradlew assembleDebug

# Build debug APK (Windows)
gradlew.bat assembleDebug

# Clean build
./gradlew clean

# Build and install directly
./gradlew installDebug
```

---

## Project Information

- **App Name**: Quillpad
- **Package Name**: `io.github.quillpad`
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: 35 (Android 15)
- **Compile SDK**: 35
- **Language**: Kotlin
- **Build System**: Gradle with Kotlin DSL

---

## Next Steps

Once you have the app running:

1. **Development**: Make changes and test on your device
2. **Debugging**: Use Android Studio's debugger (click bug icon 🐛)
3. **Testing**: Run tests with `./gradlew test`
4. **Release**: Build signed release APK for distribution

---

## Additional Resources

- [Android Developer Documentation](https://developer.android.com/docs)
- [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
- [Gradle Documentation](https://docs.gradle.org/)
- [Android Studio User Guide](https://developer.android.com/studio/intro)

---

**Need Help?** If you encounter issues not covered here, check:
- Android Studio's built-in help (`Help` → `Find Action`)
- Stack Overflow for Android development questions
- The project's GitHub issues page
