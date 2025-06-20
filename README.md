# Flutter Starknet Starter Kit

A complete Flutter starter template for building **mobile Starknet wallet applications** on Android and iOS. This project demonstrates blockchain integration, wallet functionality, and mobile-first Starknet development.

## 🎯 Project Vision

**Goal**: Create a production-ready starter kit for mobile Starknet wallets with:
- **Real wallet creation** with device-secured private keys
- **Biometric authentication** (Face ID, Touch ID, Fingerprint)
- **Account deployment** to Starknet networks
- **Transaction signing** and blockchain interactions
- **Mobile-optimized UI** components

## 📍 Current Status

### ✅ **What's Currently Working**
- **Live blockchain data fetching** - Real Starknet mainnet integration
- **Component-based architecture** - Clean, reusable UI components
- **Environment configuration** - Secure RPC endpoint management
- **iOS/Android deployment** - Ready for physical device testing
- **Basic wallet UI** - Address display, copy functionality

### 🚧 **What's Currently Demo/Placeholder**
- **Wallet creation** - Uses timestamp-based fake addresses (not real private keys)
- **Account deployment** - Shows "coming soon" message
- **Transaction signing** - No real cryptographic operations
- **Secure storage** - Not yet implemented

### 🎯 **Next Steps for Production Wallet**
1. Integrate `wallet_kit` package for real wallet functionality
2. Implement secure key generation and biometric storage
3. Add real account deployment to Starknet
4. Build transaction signing and submission
5. Add support for multiple networks (mainnet, testnet)

## 🛠 Prerequisites & Installation

### 1. **Flutter Development Environment**

#### **Install Flutter SDK**
```bash
# macOS (using Homebrew)
brew install --cask flutter

# Or download directly from: https://docs.flutter.dev/get-started/install
```

#### **Verify Flutter Installation**
```bash
flutter doctor
```
*This command checks your environment and displays a report of the status of your Flutter installation.*

### 2. **Platform-Specific Requirements**

#### **For iOS Development (macOS only)**
- **Xcode 14.0 or later** - Install from Mac App Store
- **iOS Simulator** - Included with Xcode
- **Xcode Command Line Tools**:
  ```bash
  xcode-select --install
  ```

#### **For Android Development**
- **Android Studio** - Download from [developer.android.com](https://developer.android.com/studio)
- **Android SDK** - Install through Android Studio
- **Android Emulator** or physical Android device

### 3. **Code Editor Setup**
#### **VS Code (Recommended)**
- Install [VS Code](https://code.visualstudio.com/)
- Install the **Flutter extension** by Dart Code
- Install the **Dart extension** by Dart Code

#### **Android Studio (Alternative)**
- Flutter and Dart plugins come pre-installed

### 4. **Git & Command Line Tools**
```bash
# Verify git is installed
git --version

# Install if needed (macOS)
brew install git
```

## 🚀 Getting Started

### 1. **Clone the Repository**
```bash
git clone <your-repo-url>
cd flutter_starknet_starter
```

### 2. **Install Dependencies**
```bash
# Install Flutter packages
flutter pub get

# For iOS: Install CocoaPods dependencies
cd ios && pod install && cd ..
```

### 3. **Environment Setup**
Create a `.env` file in the project root:
```bash
# Copy the example environment file
cp .env.example .env
```

Edit `.env` with your configuration:
```env
STARKNET_RPC_URL=https://starknet-mainnet.g.alchemy.com/starknet/version/rpc/v0_8/YOUR_API_KEY
```

*Note: Get a free RPC URL from [Alchemy](https://www.alchemy.com/starknet) or use public endpoints.*

### 4. **Verify Setup**
```bash
# Check for issues
flutter doctor

# Analyze code
flutter analyze

# Run tests
flutter test
```

## 📱 Running the App

### **On iOS Device/Simulator**
```bash
# List available devices
flutter devices

# Run on iOS simulator
flutter run

# Or run specifically on iOS
flutter run -d ios
```

### **On Android Device/Emulator**
```bash
# Run on Android
flutter run -d android

# For specific device
flutter run -d <device-id>
```

### **Using Xcode (iOS Only)**
For iOS development, you can also use Xcode directly:
```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace
```
Then select your device and click Run ▶️

## 🏗 Project Structure

```
flutter_starknet_starter/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── components/               # Reusable UI components
│   │   ├── wallet_card.dart     # Wallet UI component
│   │   └── blockchain_data_card.dart  # Blockchain data display
│   └── screens/                 # App screens
│       └── home_screen.dart     # Main app screen
├── android/                     # Android-specific files
├── ios/                        # iOS-specific files
├── .env                        # Environment variables (create this)
├── pubspec.yaml               # Flutter dependencies
└── CLAUDE.md                  # Development documentation
```

## 🔧 Development Workflow

### **Hot Reload**
Flutter supports hot reload for rapid development:
- **Save your changes** in VS Code/Android Studio
- Changes appear **instantly** on your device/simulator
- For major changes, use **Hot Restart** (Ctrl+Shift+F5)

### **Debugging**
- Use **Flutter Inspector** in VS Code/Android Studio
- Add breakpoints and use the debugger
- Check **Debug Console** for print statements and errors

### **Common Commands**
```bash
# Clean build files
flutter clean

# Rebuild dependencies
flutter pub get

# Check for code issues
flutter analyze

# Format code
flutter format .

# Build for release
flutter build apk        # Android
flutter build ios       # iOS
```

## 🔍 Troubleshooting

### **Common Issues**

#### **"Flutter doctor" shows issues**
- Follow the specific recommendations from `flutter doctor`
- Most issues are related to missing platform tools

#### **iOS build fails**
```bash
# Clean and rebuild
flutter clean
cd ios && pod install && cd ..
flutter run
```

#### **Android build fails**
- Ensure Android SDK is installed via Android Studio
- Check that `ANDROID_HOME` environment variable is set

#### **Dependencies issues**
```bash
# Reset dependencies
flutter clean
flutter pub get
```

### **Getting Help**
- Check **CLAUDE.md** for detailed troubleshooting
- Review [Flutter documentation](https://docs.flutter.dev/)
- Ask on [Flutter Discord](https://discord.gg/flutter)

## 🔮 Next Steps

### **For Developers**
1. **Explore the code** - Start with `lib/main.dart` and component files
2. **Understand Starknet integration** - Check `blockchain_data_card.dart` for real blockchain calls
3. **Plan wallet features** - Review the Context7 Starknet.dart documentation
4. **Implement secure storage** - Add biometric authentication for production

### **For Production Wallet**
1. Replace demo wallet with `wallet_kit` integration
2. Add secure key generation and storage
3. Implement account deployment functionality
4. Add transaction signing and submission
5. Integrate with hardware security modules

## 📚 Resources

### **Starknet Development**
- [Starknet.dart Documentation](https://starknetdart.dev/)
- [Starknet Book](https://book.starknet.io/)
- [Starknet Discord](https://discord.gg/starknet)

### **Flutter Development**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/language)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

### **Mobile Wallet Security**
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Biometric Authentication](https://pub.dev/packages/local_auth)
- [Starknet Wallet Kit](https://starknetdart.dev/packages/wallet-kit)

---

**Built with Flutter & Starknet** 🚀
