import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/provider/orderProvider.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'formScreen.dart';
import 'cartScreen.dart';
import 'editScreen.dart';
import 'detailScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _loadData;

  @override
  void initState() {
    super.initState();
    _loadData = Provider.of<DrinkMenuProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    final drinkMenuProvider = Provider.of<DrinkMenuProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6F4E37), // สีน้ำตาลเข้มเหมือนเมล็ดกาแฟ
        title: Text(
          'Drink Menu',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              if (orderProvider.orders.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      orderProvider.orders.length.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      backgroundColor: Color(0xFFF5EFE6), // พื้นหลังสีครีม
      body: FutureBuilder(
        future: _loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (drinkMenuProvider.getDrinkMenu().isEmpty) {
            return Center(
              child: Text(
                "ไม่มีสินค้าในเมนู",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: drinkMenuProvider.getDrinkMenu().length,
            itemBuilder: (context, index) {
              final DrinkMenuItem item = drinkMenuProvider.getDrinkMenu()[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(drinkItem: item)),
                  );
                },
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                              ? Image.file(
                            File(item.imageUrl!),
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 50, color: Colors.red);
                            },
                          )
                              : Icon(Icons.local_drink, size: 50, color: Colors.brown),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              item.drinkName,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '฿${item.price.toStringAsFixed(2)} - ${item.category}',
                              style: TextStyle(color: Colors.brown[700]),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditScreen(drinkItem: item)),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, drinkMenuProvider, item);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ✅ ฟังก์ชันแสดงกล่องยืนยันก่อนลบ
  void _showDeleteConfirmationDialog(BuildContext context, DrinkMenuProvider provider, DrinkMenuItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: Text("ยืนยันการลบ", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          content: Text("คุณต้องการลบ '${item.drinkName}' ออกจากเมนูหรือไม่?", style: TextStyle(color: Colors.brown[700])),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ยกเลิก
              child: Text("ยกเลิก", style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                provider.deleteDrink(item); // ลบสินค้า
                Navigator.of(context).pop(); // ปิดกล่องโต้ตอบ
              },
              child: Text("ยืนยัน", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
