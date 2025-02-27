import 'dart:io';
import 'package:flutter/material.dart';
import 'package:account/model/drinkmenuItem.dart'; // นำเข้า DrinkMenuItem

class DetailScreen extends StatelessWidget {
  final DrinkMenuItem drink; // ใช้ drink แทน item

  const DetailScreen({super.key, required this.drink}); // รับ drink แทน item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drink.drinkName), // แสดงชื่อเครื่องดื่มใน AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // ใช้ ScrollView เพื่อเลื่อนหน้าจอได้ถ้าเนื้อหามีมาก
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // รูปภาพเครื่องดื่ม
              drink.imageUrl != null
                  ? Image.file(
                File(drink.imageUrl!),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
                  : Container(
                width: double.infinity,
                height: 250,
                color: Colors.brown[200],
                child: const Icon(
                  Icons.local_cafe,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 16),

              // ชื่อเครื่องดื่ม
              Text(
                drink.drinkName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // ราคา
              Text(
                'ราคา: ฿${drink.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 16),

              // ประเภทเครื่องดื่ม
              Text(
                'ประเภท: ${drink.category}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // รายละเอียดเครื่องดื่ม (ถ้ามี)
              if (drink.description != null && drink.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'รายละเอียด: ${drink.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
