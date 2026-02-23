import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/performance_card.dart';
import 'add_sale_screen.dart';
import 'report_screen.dart';
import 'app_drawer.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Seller Dashboard')),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, ${provider.currentUser?.name ?? "Punleu"}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                "Let's check your sales performance today",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 32),

              CustomButton(
                label: 'Add New Sale',
                color: const Color(0xFF5A9B5C),
                onPressed: () => Navigator.pushNamed(context, '/add-sale'),
              ),
              const SizedBox(height: 16),

              CustomButton(
                label: 'View Daily Report',
                color: const Color(0xFF3333FF),
                onPressed: () => Navigator.pushNamed(context, '/report'),
              ),
              const SizedBox(height: 16),

              CustomButton(
                label: 'View Monthly Report',
                color: const Color(0xFFFF7F27),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Monthly report coming soon')),
                  );
                },
              ),

              const SizedBox(height: 40),
              PerformanceCard(
                percentage: provider.performancePercent,
                statusText: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}