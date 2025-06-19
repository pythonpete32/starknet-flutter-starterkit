## Zero to Starknet Flutter App on Your Phone - Minimal Setup Guide

### Prerequisites
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Install Android Studio (for Android) or Xcode (for iOS)
3. VS Code with Flutter extension (recommended)

### Step 1: Create Project
```bash
flutter create flutter_starknet_starter
cd flutter_starknet_starter
```

### Step 2: Replace pubspec.yaml
Delete everything in `pubspec.yaml` and paste this minimal setup:

```yaml
name: flutter_starknet_starter
description: A minimal Starknet Flutter starter kit

publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Starknet
  starknet: ^0.3.0
  starknet_provider: ^0.1.0
  
  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3
  
  # Local Database
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # API Calls
  dio: ^5.3.2
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  build_runner: ^2.4.6
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9

flutter:
  uses-material-design: true
```

### Step 3: Install Dependencies
```bash
flutter pub get
```

### Step 4: Basic Folder Structure
Create these folders:
```
lib/
├── models/
├── providers/
├── screens/
└── main.dart
```

### Step 5: Minimal main.dart
Replace `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starknet Starter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Starknet Starter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Minimal Starknet App'),
            ElevatedButton(
              onPressed: () {
                // TODO: Connect wallet
              },
              child: Text('Connect Wallet'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 6: Create a Basic Provider
Create `lib/providers/starknet_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starknet/starknet.dart';
import 'package:starknet_provider/starknet_provider.dart';

final starknetProvider = Provider((ref) {
  return StarknetProvider(
    nodeUri: 'https://starknet-mainnet.public.blastapi.io',
  );
});
```

### Step 7: Run on Your Phone

**For Android:**
1. Enable Developer Mode on your phone
2. Enable USB Debugging
3. Connect phone via USB
4. Run: `flutter run`

**For iOS:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select your device
3. Run: `flutter run`

### Step 8: Verify Setup
You should see:
- App launches on your phone
- Purple theme (Material 3)
- "Connect Wallet" button (doesn't do anything yet)
- No errors in console

### What You Now Have
✅ Flutter project with Starknet SDK  
✅ Riverpod for state management  
✅ Hive for local database  
✅ Material 3 theming  
✅ Code generation setup  
✅ Basic project structure  

### Next Steps (Week 1)
1. Set up code generation: `dart run build_runner build`
2. Create Extended API client with Dio
3. Implement wallet connection
4. Add WebSocket for real-time prices
5. Create basic trading models with Freezed

### Common Issues
- **iOS**: Need to run `cd ios && pod install`
- **Android**: Minimum SDK might need updating in `android/app/build.gradle`
- **Starknet connection**: The public RPC might be slow, consider getting a dedicated endpoint

This is your absolute bare minimum. Share this with your partner and you both can get the same setup running in under 30 minutes.