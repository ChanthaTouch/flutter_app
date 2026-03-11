import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class SetTargetScreen extends StatefulWidget {
  const SetTargetScreen({super.key});

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
  String? _selectedStaff;
  String? _selectedMonth = 'April';
  String? _selectedYear = '2025';
  final _targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Set Monthly Target')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildDropdown('Select Staff', _selectedStaff, ['John', 'Lina', 'Dara'], (v) {
              setState(() => _selectedStaff = v);
            }),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown('Month', _selectedMonth, ['January', 'February', 'March', 'April', 'May'], (v) {
                    setState(() => _selectedMonth = v);
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown('Year', _selectedYear, ['2024', '2025', '2026'], (v) {
                    setState(() => _selectedYear = v);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _targetController,
              decoration: const InputDecoration(
                labelText: 'Target Amount (\$)',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            CustomButton(
              label: 'Save Target',
              color: const Color(0xFF5A9B5C),
              onPressed: () {
                // TODO: save to provider / backend
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Target saved')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Text('Select $label', style: const TextStyle(color: Colors.grey)),
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}