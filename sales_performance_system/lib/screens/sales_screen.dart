import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sales_provider.dart';
import '../providers/auth_provider.dart';
import '../models/sale.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      context.read<SalesProvider>().fetchSales();
    });
  }

  void _showAddSaleDialog() {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController(
      text: DateTime.now().toString().split(' ')[0],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Sale'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final user = context.read<AuthProvider>().user;
              if (user != null) {
                final sale = Sale(
                  userId: user.id,
                  amount: double.parse(amountController.text),
                  date: dateController.text,
                  description: descriptionController.text,
                );
                final success = await context.read<SalesProvider>().createSale(sale);
                if (context.mounted) {
                  Navigator.pop(context);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sale added successfully')),
                    );
                  }
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SalesProvider>(
        builder: (context, salesProvider, _) {
          if (salesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (salesProvider.error != null) {
            return Center(child: Text('Error: ${salesProvider.error}'));
          }

          if (salesProvider.sales.isEmpty) {
            return const Center(child: Text('No sales yet'));
          }

          return ListView.builder(
            itemCount: salesProvider.sales.length,
            itemBuilder: (context, index) {
              final sale = salesProvider.sales[index];
              return ListTile(
                leading: const Icon(Icons.attach_money),
                title: Text('\$${sale.amount.toStringAsFixed(2)}'),
                subtitle: Text('${sale.date}\n${sale.description ?? ''}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSaleDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
