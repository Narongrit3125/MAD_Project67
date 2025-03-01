import 'package:flutter/material.dart';
import 'package:account/model/drinkmenuItem.dart';

class OrderProvider with ChangeNotifier {
  // รายการสั่งซื้อ
  List<DrinkMenuItem> _orders = [];

  List<DrinkMenuItem> get orders => _orders;

  // ฟังก์ชันเพิ่มรายการสั่งซื้อ
  void addOrder(DrinkMenuItem drink) {
    _orders.add(drink);
    notifyListeners();
  }

  // ฟังก์ชันลบรายการสั่งซื้อ
  void removeOrder(DrinkMenuItem drink) {
    _orders.remove(drink);
    notifyListeners();
  }

  // ฟังก์ชันล้างตะกร้าสินค้า
  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
