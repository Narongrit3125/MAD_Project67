import 'dart:io';
import 'package:flutter/material.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'editScreen.dart';

class DetailScreen extends StatelessWidget {
  final DrinkMenuItem item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.drinkName),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // ไปหน้าแก้ไข EditScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(item: item),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงรูปภาพ
            Center(
              child: item.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(item.imageUrl!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.brown[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.local_cafe, size: 80, color: Colors.white),
                    ),
            ),
            const SizedBox(height: 16),

            // แสดงชื่อเครื่องดื่ม
            Text(
              item.drinkName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // แสดงราคา
            Text(
              'ราคา: ฿${item.price}',
              style: const TextStyle(fontSize: 20, color: Colors.brown),
            ),

            // แสดงหมวดหมู่
            if (item.category.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'หมวดหมู่: ${item.category}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
