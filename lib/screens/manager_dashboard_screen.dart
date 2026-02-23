import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';
import 'set_target_screen.dart';
import 'app_drawer.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Manager Dashboard')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: screenWidth * 0.75,
                height: 52,
                child: CustomButton(
                  label: 'Set Staff Target',
                  color: const Color(0xFF4A89DC),
                  onPressed: () => Navigator.pushNamed(context, '/set-target'),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Sales Today:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${provider.todayTotal.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Staff Performance:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(
            percent,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: pctColor),
          ),
          Text(
            status,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: statusColor),
          ),
        ],
      ),
    );
  }
}