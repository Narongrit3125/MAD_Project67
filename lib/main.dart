import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/provider/orderProvider.dart';
import 'package:account/Screen/homeScreen.dart'; // ✅ เพิ่มการ import

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrinkMenuProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drink Menu App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // ✅ ใช้ HomeScreen() ให้ถูกต้อง
    );
  }
}
