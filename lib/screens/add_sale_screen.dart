import 'package:flutter/material.dart';
import 'choose_product_screen.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _customerController = TextEditingController();
  final _totalPriceController = TextEditingController();
  String _selectedDate = "Select Date:";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Sale'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Dropdown for Date
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4), color: Colors.white),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedDate,
                    items: [_selectedDate].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) {},
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const Text('Customer Name:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _customerController,
                decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.all(12), fillColor: Colors.white, filled: true),
              ),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A89DC), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChooseProductScreen()));
                  },
                  child: const Text('Select Product', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),

              const Text('Total Price:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _totalPriceController,
                decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.all(12), fillColor: Colors.white, filled: true),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5A9B5C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}