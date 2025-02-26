import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/model/drinkmenuItem.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _drinkName = '';
  double _price = 0.0;
  String _category = '';
  String? _imagePath; // เก็บพาธรูปภาพที่เลือก

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มเมนูเครื่องดื่ม'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // เลือกรูปภาพ
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(_imagePath!), width: 150, height: 150, fit: BoxFit.cover),
                        )
                      : Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.brown[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // ช่องใส่ชื่อเครื่องดื่ม
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อเครื่องดื่ม'),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อ' : null,
                onSaved: (value) => _drinkName = value!,
              ),
              
              // ช่องใส่ราคา
              TextFormField(
                decoration: const InputDecoration(labelText: 'ราคา (บาท)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'กรุณากรอกราคา' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),

              const SizedBox(height: 16),
              
              // ปุ่มบันทึก
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<DrinkMenuProvider>(context, listen: false).addDrink(
                      DrinkMenuItem(
                        keyID: DateTime.now().millisecondsSinceEpoch, // ✅ ใช้ int แทน
                        drinkName: _drinkName,
                        price: _price,
                        category: _category,
                        imageUrl: _imagePath, // บันทึกพาธรูปภาพ
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                child: const Text('บันทึก', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
