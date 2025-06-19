import 'package:flutter/material.dart';
import '../components/blockchain_data_card.dart';
import '../components/wallet_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Starknet Starter'),
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Icon(
              Icons.rocket_launch,
              size: 60,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 16),
            Text(
              'Starknet Flutter Starter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Wallet & Blockchain Demo',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            
            // Wallet Section
            WalletCard(),
            SizedBox(height: 20),
            
            // Blockchain Data Section
            BlockchainDataCard(),
            SizedBox(height: 20),
            
            // Footer
            Text(
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