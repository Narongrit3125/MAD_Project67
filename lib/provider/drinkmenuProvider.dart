import 'package:flutter/foundation.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'package:account/database/drinkmenuDB.dart';

class DrinkMenuProvider with ChangeNotifier {
  final DrinkMenuDB _db = DrinkMenuDB(dbName: 'drinkmenu.db'); // ใช้ฐานข้อมูลหลัก
  List<DrinkMenuItem> drinkMenu = [];

  List<DrinkMenuItem> getDrinkMenu() {
    return drinkMenu;
  }

  Future<void> initData() async {
    drinkMenu = await _db.loadAllData();
    notifyListeners();
  }

  Future<void> addDrink(DrinkMenuItem drink) async {
    await _db.insertDatabase(drink);
    await initData();
  }

  Future<void> updateDrink(DrinkMenuItem drink) async {
    await _db.updateData(drink); // อัปเดตข้อมูลในฐานข้อมูล
    await initData();  // รีเฟรชข้อมูลใน provider
    notifyListeners();  // แจ้งให้หน้าจอที่เชื่อมต่อ provider รีเฟรช
  }

  Future<void> deleteDrink(DrinkMenuItem drink) async {
    await _db.deleteData(drink);
    await initData();  // โหลดข้อมูลใหม่
    notifyListeners(); // แจ้งให้ Consumer ทราบว่ามีการเปลี่ยนแปลงข้อมูล
  }


  List<DrinkMenuItem> filterByCategory(String category) {
    return drinkMenu.where((drink) => drink.category == category).toList();
  }

  Future<void> clearData() async {
    await _db.clearDatabase();
    drinkMenu.clear();
    notifyListeners();
  }
}
