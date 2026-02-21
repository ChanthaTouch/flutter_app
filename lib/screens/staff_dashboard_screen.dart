import 'package:flutter/material.dart';
import 'add_sale_screen.dart';
import 'report_screen.dart';
import 'app_drawer.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seller Dashboard')),
      drawer: const AppDrawer(), // Integrated Side Menu
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Welcome, Punleu!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildMenuButton(context, 'Add Sale', const Color(0xFF5A9B5C), () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddSaleScreen()));
            }),
            const SizedBox(height: 16),
            _buildMenuButton(context, 'View Daily Report', const Color(0xFF3333FF), () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportScreen()));
            }),
            const SizedBox(height: 16),
            _buildMenuButton(context, 'View Monthly Report', const Color(0xFFFF7F27), () {}),
            const SizedBox(height: 30),
            _buildPerformanceCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
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
              Icon(Icons.trending_up, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text('Near Target', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onTap,
        child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}