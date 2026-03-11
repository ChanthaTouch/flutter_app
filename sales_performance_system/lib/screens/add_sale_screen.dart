import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../models/sale.dart';
import '../widgets/custom_button.dart';
import 'choose_product_screen.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _customerController = TextEditingController();
  final _totalPriceController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Sale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _customerController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _totalPriceController,
              decoration: const InputDecoration(
                labelText: 'Total Price (\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Center(
              child: CustomButton(
                label: 'Select Product',
                color: const Color(0xFF4A89DC),
                onPressed: () => Navigator.pushNamed(context, '/choose-product'),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                label: 'Submit Sale',
                color: const Color(0xFF5A9B5C),
                onPressed: () {
                  if (_customerController.text.isNotEmpty && _totalPriceController.text.isNotEmpty) {
                    final price = double.tryParse(_totalPriceController.text) ?? 0;
                    final provider = Provider.of<AppProvider>(context, listen: false);
                    provider.addSale(Sale(
                      customerName: _customerController.text,
                      totalPrice: price,
                      date: _selectedDate ?? DateTime.now(),
                    ));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sale added successfully')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}