import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../widgets/performance_card.dart';
import '../widgets/custom_button.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Sales Report')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customer Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: 16),

            ...provider.sales.map((sale) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sale.customerName, style: const TextStyle(fontSize: 15)),
                      Text('\$${sale.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                )),

            const Divider(thickness: 1.5),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  '\$${provider.todayTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTargetBox(context, 'Daily Target', '2,000 \$'),
                _buildTargetBox(context, 'Weekly Target', '14,000 \$'),
                _buildTargetBox(context, 'Monthly Target', '60,000 \$'),
              ],
            ),
            const SizedBox(height: 32),

            PerformanceCard(
              percentage: provider.performancePercent,
              statusText: '',
            ),

            const SizedBox(height: 32),

            Center(
              child: CustomButton(
                label: 'Back to Dashboard',
                color: Colors.grey.shade700,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetBox(BuildContext context, String label, String value) {
    final width = MediaQuery.of(context).size.width * 0.28;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}