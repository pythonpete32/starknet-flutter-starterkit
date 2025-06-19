# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Starknet Documentation Access

**IMPORTANT**: For any Starknet.dart SDK questions or implementation details, use Context7 to access the official documentation:

```
Use Context7 with library ID: /context7/starknetdart_dev
```

This provides access to:
- Official Starknet.dart SDK documentation 
- API reference for JsonRpcProvider, BlockId, and other core types
- Code examples for blockchain interactions
- WebSocket subscriptions and real-time data patterns
- Error handling with Result pattern

## Core Architecture

### Target Platforms
**This project targets Android and iOS only** - desktop and web platform folders have been removed for simplicity.

### Starknet Integration
- Uses `JsonRpcProvider` from `starknet_provider` package
- RPC endpoint configured via `STARKNET_RPC_URL` in `.env` file

### Environment Configuration
- RPC URL stored in `.env` file (not committed to git)
- Loaded via `flutter_dotenv` package in main()
- Fallback to public RPC if environment variable missing

## Critical Requirements

### Before Completing Any Work
**ALWAYS run the IDE diagnostics tool to ensure no errors:**
```bash
flutter analyze
```
All diagnostic errors must be resolved before considering work complete. Check both:
- Static analysis errors (undefined methods, incorrect imports, etc.)
- Runtime errors and type mismatches
- Unused imports and dead code warnings

## Issues Encountered and Solutions

### Issue 1: Wallet Creation RangeError
**Problem**: Wallet creation was failing with `RangeError (start): Invalid value: Not in inclusive range 0..19: -19`

**Root Cause**: Timestamp string manipulation in `wallet_card.dart` line 29 was using incorrect substring logic:
```dart
// Broken code:
timestamp.substring(timestamp.length - 32).padLeft(32, '0')
```

**Solution**: Fixed string manipulation to ensure proper hex address generation:
```dart
// Fixed code:
final timestampHex = timestamp.padLeft(32, '0').substring(0, 32);
final accountAddress = Felt.fromHexString('0x$timestampHex');
```

**Location**: `lib/components/wallet_card.dart:29-30`

### Issue 2: Flutter Device Detection Problems
**Problem**: Flutter CLI couldn't detect the physical iPhone device, showing "unavailable" status

**Root Cause**: Multiple factors:
- Stale build cache and generated plugin files
- iOS dependency conflicts in Pods
- Build system state corruption

**Solution Applied**:
1. **Complete project cleanup**:
   ```bash
   flutter clean
   rm -rf ios/Pods ios/Podfile.lock
   ```

2. **Fresh dependency installation**:
   ```bash
   flutter pub get
   pod install --clean-install
   ```

3. **Xcode build system reset**:
   - Close Xcode completely (`pkill -f Xcode`)
   - Reopen workspace (`open ios/Runner.xcworkspace`)
   - Clean Build Folder (Product → Clean Build Folder)

### Issue 3: Path Provider Foundation Errors
**Problem**: Generated plugin registrant files showing "Module 'path_provider_foundation' not found" errors

**Root Cause**: Stale generated plugin files from previous builds conflicting with updated dependencies

**Solution**: The `flutter clean` + `pod install --clean-install` sequence regenerated all plugin files correctly

### Issue 4: Xcode Build Failures
**Problem**: Multiple Xcode build failures showing "Invalid reuse after invalidation" errors

**Root Cause**: Build system cache corruption and dependency conflicts

**Solution**: Complete clean rebuild sequence resolved all build system issues

### iOS Deployment Best Practices

**For Physical iPhone Deployment**:
1. Always use Xcode for physical device deployment (not Flutter CLI)
2. Ensure device is trusted and Developer Mode is enabled
3. Use `open ios/Runner.xcworkspace` to open the project correctly
4. If build issues occur, follow the complete cleanup sequence above

**Key Commands for Troubleshooting**:
```bash
# Complete project reset
flutter clean
rm -rf ios/Pods ios/Podfile.lock
flutter pub get
pod install --clean-install

# Device detection
flutter devices
xcrun devicectl list devices

# Analysis
flutter analyze
```

**Working Device IDs (for reference)**:
- Physical iPhone: `00008120-001C54EC26F1A01E`
- iPhone 16 Simulator: `C9CAE84D-0F87-4152-AF38-D9D10D6B9028`