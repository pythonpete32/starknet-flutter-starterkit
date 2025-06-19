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