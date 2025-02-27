import 'dart:io';
import 'package:flutter/material.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'package:provider/provider.dart';
import 'detailScreen.dart'; // นำเข้า DetailScreen
import 'formScreen.dart';   // ถ้ามีการใช้งาน FormScreen
import 'editScreen.dart';   // เพิ่มการนำเข้า EditScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DrinkMenuProvider>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SD Drink Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<DrinkMenuProvider>(
        builder: (context, provider, child) {
          if (provider.drinkMenu.isEmpty) {
            return const Center(
              child: Text('ไม่มีเมนูเครื่องดื่ม'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: provider.drinkMenu.length,
              itemBuilder: (context, index) {
                final drink = provider.drinkMenu[index];
                return GestureDetector(
                  onTap: () {
                    // เมื่อคลิกการ์ดให้ไปที่หน้า DetailScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          drink: drink, // ส่งข้อมูล drink ไปยัง DetailScreen
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        // รูปภาพเครื่องดื่ม
                        drink.imageUrl != null
                            ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.file(
                            File(drink.imageUrl!),
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.brown[200],
                          child: const Icon(
                            Icons.local_cafe,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ชื่อเครื่องดื่ม
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    drink.drinkName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '฿ ${drink.price}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.brown[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'ประเภท: ${drink.category}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              // ปุ่มลบและแก้ไข
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditScreen(
                                            drink: drink, // ส่งข้อมูล drink ไปยัง EditScreen
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _confirmDelete(context, provider, drink);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // ฟังก์ชันยืนยันการลบ
  void _confirmDelete(
      BuildContext context, DrinkMenuProvider provider, DrinkMenuItem drink) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: Text('คุณต้องการลบ "${drink.drinkName}" หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                if (drink.keyID != null) {
                  provider.deleteDrink(drink); // ส่ง DrinkMenuItem ให้ถูกต้อง
                  Navigator.pop(context);
                  // แจ้งเตือนว่าลบสำเร็จ
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${drink.drinkName} ถูกลบแล้ว'),
                      backgroundColor: Colors.redAccent,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('ลบ', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
