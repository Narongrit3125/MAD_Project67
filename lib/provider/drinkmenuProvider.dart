import 'package:flutter/foundation.dart';
import 'package:account/model/drinkmenuItem.dart';
import 'package:account/database/drinkmenuDB.dart';

class DrinkMenuProvider with ChangeNotifier {
  final DrinkMenuDB _db = DrinkMenuDB(dbName: 'drinkmenu.db');
  List<DrinkMenuItem> drinkMenu = [];

  List<DrinkMenuItem> getDrinkMenu() {
    return drinkMenu;
  }

  Future<void> initData() async {
    print("🔄 กำลังโหลดข้อมูลเมนูเครื่องดื่ม...");
    drinkMenu = await _db.loadAllData();
    print("✅ โหลดเมนูสำเร็จ: ${drinkMenu.length} รายการ");
    notifyListeners();
  }

  Future<void> addDrink(DrinkMenuItem drink) async {
    await _db.insertDatabase(drink);
    await initData();
  }

  Future<void> updateDrink(DrinkMenuItem drink) async {
    await _db.updateData(drink);
    await initData();
  }

  Future<void> deleteDrink(DrinkMenuItem drink) async {
    await _db.deleteData(drink);
    await initData();
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
