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
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditScreen(drink: item)), // ✅ ส่งพารามิเตอร์ให้ถูกต้อง
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            item.imageUrl != null
                ? Image.file(File(item.imageUrl!), width: double.infinity, height: 200, fit: BoxFit.cover)
                : Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.brown[200],
                    child: const Icon(Icons.local_cafe, color: Colors.white, size: 100),
                  ),
            const SizedBox(height: 16),
            Text(
              item.drinkName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'ราคา: ฿${item.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'หมวดหมู่: ${item.category}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
