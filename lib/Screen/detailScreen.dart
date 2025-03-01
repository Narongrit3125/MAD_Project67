import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'package:account/provider/orderProvider.dart';

class DetailScreen extends StatelessWidget {
  final DrinkMenuItem drinkItem;

  DetailScreen({required this.drinkItem});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(drinkItem.drinkName)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: drinkItem.imageUrl != null && drinkItem.imageUrl!.isNotEmpty
                  ? Image.file(
                File(drinkItem.imageUrl!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              )
                  : Icon(Icons.local_drink, size: 100, color: Colors.blue),
            ),
            SizedBox(height: 16),
            Text(drinkItem.drinkName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Category: ${drinkItem.category}', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
            SizedBox(height: 8),
            Text('Price: \$${drinkItem.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 16),
            Text('Description:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(drinkItem.description.isNotEmpty ? drinkItem.description : "No description available.",
                style: TextStyle(fontSize: 16)),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  orderProvider.addOrder(drinkItem); // เพิ่มสินค้าเข้าตะกร้า
                  _showAddedToCartPopup(context); // แสดง Popup แจ้งเตือน
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text("เพิ่มลงตะกร้า"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ ฟังก์ชันแสดง Popup แจ้งเตือนเมื่อเพิ่มสินค้าลงตะกร้า
  void _showAddedToCartPopup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("เพิ่ม '${drinkItem.drinkName}' ลงตะกร้าแล้ว!"),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }
}
