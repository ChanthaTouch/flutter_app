import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sale Daily Reported')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customer Name:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(thickness: 1, color: Colors.black),
            const SizedBox(height: 16),
            _buildRow('Customer A', '\$30'),
            const SizedBox(height: 24),
            _buildRow('Customer B', '\$30'),
            const SizedBox(height: 24),
            const Divider(thickness: 1, color: Colors.black),
            const SizedBox(height: 8),
            _buildRow('Total:', '\$60', isBold: true),
            
            const Spacer(),
            
            // Targets Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTargetBox('Daily Target:', '2,000 \$'),
                _buildTargetBox('Weekly Target:', '18,000 \$'),
                _buildTargetBox('Monthly Target:', '90,000 \$'),
              ],
            ),
            const SizedBox(height: 20),

            // Performance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFF7F27),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Text('Your Performance: 75%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Near Target', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(amount, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.bold)),
      ],
    );
  }

  Widget _buildTargetBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: 90,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: Colors.white),
          child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}