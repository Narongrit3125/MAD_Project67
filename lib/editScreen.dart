import 'package:account/model/drinkmenuItem.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final DrinkMenuItem drink;

  const EditScreen({super.key, required this.drink}); // ✅ รับแค่ 1 argument
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _drinkName;
  late double _price;
  late String _category;
  String? _imagePath;
  late String _description;

  @override
  void initState() {
    super.initState();
    _drinkName = widget.drink.drinkName; // ✅ เปลี่ยนจาก widget.item เป็น widget.drink
    _price = widget.drink.price;
    _category = widget.drink.category;
    _imagePath = widget.drink.imageUrl;
    _description = widget.drink.description ?? ''; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แก้ไขเมนู'), backgroundColor: Colors.brown),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _drinkName,
                decoration: const InputDecoration(labelText: 'ชื่อเครื่องดื่ม'),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อ' : null,
                onSaved: (value) => _drinkName = value!,
              ),

              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'ราคา (บาท)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'กรุณากรอกราคา' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),

              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'รายละเอียดเครื่องดื่ม'),
                maxLines: 3,
                onSaved: (value) => _description = value ?? '',
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // อัปเดตข้อมูลในฐานข้อมูลและรีเฟรชข้อมูลใน provider
                    Provider.of<DrinkMenuProvider>(context, listen: false).updateDrink(
                      DrinkMenuItem(
                        keyID: widget.drink.keyID,
                        drinkName: _drinkName,
                        price: _price,
                        category: _category,
                        imageUrl: _imagePath,
                        description: _description,
                      ),
                    );
                    Navigator.pop(context); // ปิดหน้าจอหลังจากบันทึก
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                child: const Text('บันทึกการแก้ไข', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




