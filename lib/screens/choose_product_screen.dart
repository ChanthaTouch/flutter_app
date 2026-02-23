import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class ChooseProductScreen extends StatefulWidget {
  const ChooseProductScreen({super.key});

  @override
  State<ChooseProductScreen> createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  final List<String> products = ['Knauf', 'C-line', 'ESB/DB', 'ម្សៅ', 'MC', 'PVC', 'ឈើ'];

  // Quantity for each product (starts at 1)
  final List<int> _quantities = List.filled(7, 1);

  // Mock options for dropdowns
  final List<String> typeOptions = ['Type A', 'Type B', 'Type C'];
  final List<String> sizeOptions = ['Small', 'Medium', 'Large', 'XL'];

  String? selectedAddMore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Product'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(index);
                },
              ),
            ),

            const SizedBox(height: 12),

            // "ថែមទៀត" row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A89DC),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'ថែមទៀត',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedAddMore,
                      hint: const Text('ប្រភេទ', style: TextStyle(fontSize: 13)),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: typeOptions
                          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                          .toList(),
                      onChanged: (value) => setState(() => selectedAddMore = value),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Green Submit button using your reusable CustomButton
            CustomButton(
              label: 'Submit',
              color: const Color(0xFF5A9B5C),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Products submitted successfully!')),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final title = products[index];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Blue Product Name Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title selected')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A89DC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ប្រភេទ (Type)
            _buildDropdownRow('ប្រភេទ:', typeOptions),

            const SizedBox(height: 8),

            // ខ្នាត (Size)
            _buildDropdownRow('ខ្នាត:', sizeOptions),

            const SizedBox(height: 12),

            // ចំនួន (Quantity) Stepper
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ចំនួន:', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red, size: 22),
                  onPressed: () {
                    if (_quantities[index] > 1) {
                      setState(() => _quantities[index]--);
                    }
                  },
                ),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    '${_quantities[index]}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.green, size: 22),
                  onPressed: () => setState(() => _quantities[index]++),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow(String label, List<String> options) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButton<String>(
              value: null,
              hint: const Text('Select', style: TextStyle(fontSize: 12)),
              isExpanded: true,
              underline: const SizedBox(),
              items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}