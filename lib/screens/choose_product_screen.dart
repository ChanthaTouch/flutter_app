import 'package:flutter/material.dart';

class ChooseProductScreen extends StatefulWidget {
  const ChooseProductScreen({super.key});

  @override
  State<ChooseProductScreen> createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  final List<String> products = ['Knauf', 'C-line', 'ESB/DB', 'ម្សៅ', 'MC', 'PVC', 'ឈើ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65, // Adjusts height of the card
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(products[index]);
                },
              ),
            ),
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A9B5C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String title) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A89DC), // Blue color from UI
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            onPressed: () {},
            child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        // ប្រភេទ (Type)
        Row(
          children: [
            const Text('ប្រភេទ:', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 20,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: Colors.white),
                child: const Icon(Icons.arrow_drop_down, size: 16),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        // ខ្នាត (Size)
        Row(
          children: [
            const Text('ខ្នាត:', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 20,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: Colors.white),
                child: const Icon(Icons.arrow_drop_down, size: 16),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        // ចំនួន (Quantity)
        Row(
          children: [
            const Text('ចំនួន:', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            const Icon(Icons.remove_circle_outline, size: 16),
            Expanded(
              child: Container(
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: Colors.white),
              ),
            ),
            const Icon(Icons.add_circle_outline, size: 16),
          ],
        ),
      ],
    );
  }
}