import 'package:flutter/material.dart';
import 'set_target_screen.dart';
import 'app_drawer.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Dashboard')),
      drawer: const AppDrawer(), // Integrated Side Menu
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 250,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A89DC), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SetTargetScreen())),
                  child: const Text('Set Staff Target', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily Sales Today:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$500', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Staff Performance:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildStaffRow('John:', '90%', 'Near Target', Colors.green, Colors.black),
            const Divider(),
            _buildStaffRow('Lina:', '120%', 'Achieved', Colors.green, Colors.green),
            const Divider(),
            _buildStaffRow('Dara:', '75%', 'Under Target', Colors.red, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffRow(String name, String percent, String status, Color pctColor, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(percent, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: pctColor)),
          Text(status, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: statusColor)),
        ],
      ),
    );
  }
}