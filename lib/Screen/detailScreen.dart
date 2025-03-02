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
      appBar: AppBar(
        backgroundColor: Color(0xFF6F4E37), // สีน้ำตาลกาแฟ
        title: Text(
          drinkItem.drinkName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFFF5EFE6), // สีพื้นหลังโทนอุ่น
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงรูปภาพเครื่องดื่ม
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: drinkItem.imageUrl != null && drinkItem.imageUrl!.isNotEmpty
                    ? Image.file(
                  File(drinkItem.imageUrl!),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 80, color: Colors.red);
                  },
                )
                    : Icon(Icons.local_drink, size: 100, color: Colors.brown),
              ),
            ),
            SizedBox(height: 20),

            // ชื่อเครื่องดื่ม
            Text(
              drinkItem.drinkName,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.brown[800]),
            ),
            SizedBox(height: 8),

            // หมวดหมู่
            Text(
              'Category: ${drinkItem.category}',
              style: TextStyle(fontSize: 18, color: Colors.brown[600]),
            ),
            SizedBox(height: 8),

            // ราคา
            Text(
              'Price: \$${drinkItem.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[700]),
            ),
            SizedBox(height: 16),

            // คำอธิบาย
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown[800]),
            ),
            SizedBox(height: 4),
            Text(
              drinkItem.description.isNotEmpty ? drinkItem.description : "No description available.",
              style: TextStyle(fontSize: 16, color: Colors.brown[700]),
            ),

            Spacer(),

            // ปุ่มเพิ่มลงตะกร้า
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  orderProvider.addOrder(drinkItem);
                  _showAddedToCartPopup(context);
                },
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                label: Text(
                  "เพิ่มลงตะกร้า",
                  style: TextStyle(fontSize: 18, color: Color(0xFFFFF8E1)), // เปลี่ยนเป็นสีขาวนวล
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F4E37), // สีน้ำตาลเข้ม
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันแสดง Popup แจ้งเตือน
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
