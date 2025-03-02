import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/model/drinkmenuItem.dart';

class EditScreen extends StatefulWidget {
  final DrinkMenuItem drinkItem;

  EditScreen({required this.drinkItem});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _drinkName;
  late double _price;
  late String _category;
  late String _description;

  @override
  void initState() {
    super.initState();
    _drinkName = widget.drinkItem.drinkName;
    _price = widget.drinkItem.price;
    _category = widget.drinkItem.category;
    _description = widget.drinkItem.description;
  }

  @override
  Widget build(BuildContext context) {
    final drinkMenuProvider = Provider.of<DrinkMenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6F4E37),
        title: Text(
          'Edit Drink Menu',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFFF5EFE6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // รูปภาพตัวอย่าง
                if (widget.drinkItem.imageUrl != null && widget.drinkItem.imageUrl!.isNotEmpty)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(widget.drinkItem.imageUrl!),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 50, color: Colors.red);
                        },
                      ),
                    ),
                  )
                else
                  Center(
                    child: Icon(Icons.local_drink, size: 80, color: Colors.brown),
                  ),
                SizedBox(height: 20),

                // ชื่อเครื่องดื่ม
                _buildTextField('Drink Name', _drinkName, (value) => _drinkName = value!),
                SizedBox(height: 12),

                // ราคา
                _buildTextField('Price', _price.toString(), (value) => _price = double.parse(value!), isNumber: true),
                SizedBox(height: 12),

                // หมวดหมู่
                _buildTextField('Category', _category, (value) => _category = value!),
                SizedBox(height: 12),

                // คำอธิบาย
                _buildTextField('Description', _description, (value) => _description = value!, maxLines: 3),
                SizedBox(height: 20),

                // ปุ่มอัปเดต
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      final updatedDrink = DrinkMenuItem(
                        keyID: widget.drinkItem.keyID,
                        drinkName: _drinkName,
                        price: _price,
                        category: _category,
                        description: _description,
                        imageUrl: widget.drinkItem.imageUrl,
                      );
                      drinkMenuProvider.updateDrink(updatedDrink);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6F4E37),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Update Drink',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String?) onSaved, {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyle(fontSize: 16, color: Colors.brown[800]),
      maxLines: maxLines,
      onSaved: onSaved,
    );
  }
}