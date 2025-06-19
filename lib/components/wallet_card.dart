import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starknet/starknet.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({super.key});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  String _walletStatus = 'No wallet created';
  String? _walletAddress;
  bool _isCreatingWallet = false;

  Future<void> _createWallet() async {
    setState(() {
      _isCreatingWallet = true;
      _walletStatus = '🔄 Creating wallet...';
    });

    try {
      // Generate a random private key for demo purposes
      // In a real app, you'd use secure key generation and storage
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Create mock account address (in real app, derive from private key)
      final timestampHex = timestamp.padLeft(32, '0').substring(0, 32);
      final accountAddress = Felt.fromHexString('0x$timestampHex'); // Semi-random address
      
      setState(() {
        _walletAddress = accountAddress.toHexString();
        _walletStatus = '''✅ Wallet Created!
Address: ${_walletAddress!.substring(0, 10)}...${_walletAddress!.substring(_walletAddress!.length - 8)}
Status: Ready for deployment''';
        _isCreatingWallet = false;
      });

    } catch (e) {
      setState(() {
        _walletStatus = '❌ Error creating wallet: ${e.toString()}';
        _isCreatingWallet = false;
      });
    }
  }

  Future<void> _copyAddress() async {
    if (_walletAddress != null) {
      await Clipboard.setData(ClipboardData(text: _walletAddress!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address copied to clipboard!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                'Starknet Wallet',
                style: TextStyle(fontSize: 16, color: Colors.blue[800], fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Wallet Status
          Text(
            _walletStatus,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Wallet Actions
          Column(
            children: [
              if (_walletAddress == null) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isCreatingWallet ? null : _createWallet,
                    icon: _isCreatingWallet 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_circle),
                    label: Text(_isCreatingWallet ? 'Creating...' : 'Create Wallet'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _copyAddress,
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Address'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Placeholder for deploy account
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deploy account functionality coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Deploy Account'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}