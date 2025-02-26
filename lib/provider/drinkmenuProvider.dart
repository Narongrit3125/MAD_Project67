import 'package:flutter/foundation.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'package:account/database/drinkmenuDB.dart';

class DrinkMenuProvider with ChangeNotifier {
  final DrinkMenuDB _db = DrinkMenuDB(dbName: 'drinkmenu.db'); // กำหนด db ให้เป็น final
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
    await initData(); // โหลดข้อมูลใหม่
  }

  Future<void> deleteDrink(DrinkMenuItem drink) async {
    await _db.deleteData(drink);
    await initData();
  }

  Future<void> updateDrink(DrinkMenuItem drink) async {
    await _db.updateData(drink);
    await initData();
  }

  List<DrinkMenuItem> filterByCategory(String category) {
    return drinkMenu.where((drink) => drink.category == category).toList();
  }

  Future<void> clearData() async {
    await _db.clearDatabase(); // ต้องเพิ่มฟังก์ชันนี้ใน `DrinkMenuDB`
    drinkMenu.clear();
    notifyListeners();
  }
}
