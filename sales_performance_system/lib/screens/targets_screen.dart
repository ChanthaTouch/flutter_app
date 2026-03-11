import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/targets_provider.dart';
import '../providers/auth_provider.dart';
import '../models/target.dart';

class TargetsScreen extends StatefulWidget {
  const TargetsScreen({super.key});

  @override
  State<TargetsScreen> createState() => _TargetsScreenState();
}

class _TargetsScreenState extends State<TargetsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TargetsProvider>().fetchTargets();
    });
  }

  void _showAddTargetDialog() {
    final amountController = TextEditingController();
    final periodController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Target'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Target Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: periodController,
              decoration: const InputDecoration(labelText: 'Period (e.g., 2026-03)'),
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
                final target = Target(
                  userId: user.id,
                  targetAmount: double.parse(amountController.text),
                  period: periodController.text,
                  description: descriptionController.text,
                );
                final success = await context.read<TargetsProvider>().createTarget(target);
                if (context.mounted) {
                  Navigator.pop(context);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Target added successfully')),
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
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      body: Consumer<TargetsProvider>(
        builder: (context, targetsProvider, _) {
          if (targetsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (targetsProvider.error != null) {
            return Center(child: Text('Error: ${targetsProvider.error}'));
          }

          if (targetsProvider.targets.isEmpty) {
            return const Center(child: Text('No targets yet'));
          }

          return ListView.builder(
            itemCount: targetsProvider.targets.length,
            itemBuilder: (context, index) {
              final target = targetsProvider.targets[index];
              return ListTile(
                leading: const Icon(Icons.track_changes),
                title: Text('\$${target.targetAmount.toStringAsFixed(2)}'),
                subtitle: Text('${target.period}\n${target.description ?? ''}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: user?.isManager == true
          ? FloatingActionButton(
              onPressed: _showAddTargetDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
