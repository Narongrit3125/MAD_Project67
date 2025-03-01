import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/orderProvider.dart';
import 'package:account/model/drinkmenuItem.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: orderProvider.orders.isEmpty
          ? Center(child: Text('ตะกร้าว่างเปล่า', style: TextStyle(fontSize: 18)))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final DrinkMenuItem item = orderProvider.orders[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: item.imageUrl != null && item.imageUrl!.isNotEmpty
                        ? Image.file(
                      File(item.imageUrl!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Icon(Icons.local_drink, size: 50, color: Colors.blue),
                    title: Text(item.drinkName, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('฿${item.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        orderProvider.removeOrder(item);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                if (orderProvider.orders.isNotEmpty) {
                  orderProvider.clearOrders();
                  _showOrderConfirmation(context);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: Colors.green,
              ),
              child: Text('สั่งซื้อ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('สั่งซื้อสำเร็จ!'),
          content: Text('ขอบคุณที่สั่งซื้อสินค้า'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ปิด', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}
