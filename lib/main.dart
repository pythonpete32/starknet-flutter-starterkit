import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starknet_provider/starknet_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starknet SDK Starter Kit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StarknetStarterDemo(),
    );
  }
}

class StarknetStarterDemo extends StatefulWidget {
  const StarknetStarterDemo({super.key});

  @override
  State<StarknetStarterDemo> createState() => _StarknetStarterDemoState();
}

class _StarknetStarterDemoState extends State<StarknetStarterDemo> {
  String _blockInfo = 'Tap to fetch blockchain data';
  bool _isLoading = false;
  JsonRpcProvider? _provider;

  Future<void> _initializeStarknetSDK() async {
    setState(() {
      _isLoading = true;
      _blockInfo = '🔄 Initializing Starknet SDK...';
    });

    try {
      // Initialize the official Starknet SDK provider
      final rpcUrl = dotenv.env['STARKNET_RPC_URL'] ?? 'https://starknet-mainnet.public.blastapi.io';
      _provider = JsonRpcProvider(
        nodeUri: Uri.parse(rpcUrl),
      );

      // Fetch blockchain data to prove SDK is working
      await _fetchLatestBlockData();

      setState(() {
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _blockInfo = '❌ SDK Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchLatestBlockData() async {
    if (_provider == null) return;
    
    try {
      // Fetch both block data and chain ID
      final blockResult = await _provider!.getBlockWithTxHashes(BlockId.latest);
      final chainIdResult = await _provider!.chainId();
      
      String blockData = '';
      String chainData = '';
      
      blockResult.when(
        result: (block) {
          blockData = '''📦 Latest Block:
• Timestamp: ${DateTime.fromMillisecondsSinceEpoch(block.timestamp * 1000)}
• Transactions: ${block.transactions.length}
• Sequencer: ${block.sequencerAddress.toHexString().substring(0, 16)}...
• Parent Hash: ${block.parentHash.toHexString().substring(0, 16)}...''';
        },
        error: (error) {
          blockData = '❌ Block Error: $error';
        },
      );
      
      chainIdResult.when(
        result: (chainId) {
          chainData = '''🔗 Network Info:
• Chain ID: $chainId
• RPC: Connected ✅
• Status: Live Data ✅''';
        },
        error: (error) {
          chainData = '❌ Chain Error: $error';
        },
      );
      
      setState(() {
        _blockInfo = '$blockData\n\n$chainData';
      });
      
    } catch (e) {
      setState(() {
        _blockInfo = '❌ Exception: ${e.toString()}';
      });
    }
  }

  Future<void> _refreshBlockData() async {
    if (_provider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please initialize SDK first')),
      );
      return;
    }
    
    setState(() {
      _blockInfo = '🔄 Refreshing blockchain data...';
    });
    
    await _fetchLatestBlockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Starknet Blockchain Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.block,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Live Starknet Data',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // Blockchain Data Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.block, color: Colors.purple[600], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Blockchain Data',
                        style: TextStyle(fontSize: 16, color: Colors.purple[800], fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _blockInfo,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Action Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _initializeStarknetSDK,
                    icon: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                    label: Text(_isLoading ? 'Loading...' : 'Fetch Blockchain Data'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                
                if (_provider != null) ...[
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _refreshBlockData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Data'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              'Powered by Starknet.dart SDK',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}