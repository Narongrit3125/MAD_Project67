import 'package:account/model/drinkmenuItem.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final DrinkMenuItem item;
  
  const EditScreen({super.key, required this.item});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final drinkNameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  String _selectedCategory = 'กาแฟ'; // ค่าเริ่มต้นของประเภทเครื่องดื่ม

  final List<String> _categories = ['กาแฟ', 'นม' ,'ชา', 'น้ำผลไม้', 'สมูทตี้' , 'อิตาเลี่ยนโซดา'];

  @override
  void initState() {
    super.initState();
    drinkNameController.text = widget.item.drinkName;
    priceController.text = widget.item.price.toString();
    categoryController.text = widget.item.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('แก้ไขเมนูเครื่องดื่ม'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ชื่อเครื่องดื่ม',
                  border: OutlineInputBorder(),
                ),
                controller: drinkNameController,
                validator: (value) => value!.isEmpty ? "กรุณาป้อนชื่อเครื่องดื่ม" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ราคา (บาท)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "กรุณาป้อนราคา";
                  try {
                    double price = double.parse(value);
                    if (price <= 0) return "กรุณาป้อนราคามากกว่า 0";
                  } catch (e) {
                    return "กรุณาป้อนเป็นตัวเลขเท่านั้น";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'ประเภทเครื่องดื่ม',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var provider = Provider.of<DrinkMenuProvider>(context, listen: false);
                    
                    DrinkMenuItem updatedItem = DrinkMenuItem(
                      keyID: widget.item.keyID,
                      drinkName: drinkNameController.text,
                      price: double.parse(priceController.text),
                      category: categoryController.text,
                      dateAdded: widget.item.dateAdded,
                    );

                    provider.updateDrink(updatedItem);
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('บันทึกการแก้ไข'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
