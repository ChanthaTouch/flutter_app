import 'package:flutter/material.dart';

class SetTargetScreen extends StatefulWidget {
  const SetTargetScreen({super.key});

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Monthly Target')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildMockDropdown('Select Staff'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMockDropdown('Month:  April')),
                const SizedBox(width: 8),
                Expanded(child: _buildMockDropdown('2024')),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Target Amount: \$2000',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A9B5C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockDropdown(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          const Icon(Icons.arrow_drop_down, color: Colors.black54),
        ],
      ),
    );
  }
}