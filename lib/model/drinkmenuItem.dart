class DrinkMenuItem {
  int? keyID;
  String drinkName;
  double price;
  String category;
  DateTime dateAdded;
  String? imageUrl; // เก็บพาธรูปภาพ

  DrinkMenuItem({
    this.keyID,
    required this.drinkName,
    required this.price,
    required this.category,
    DateTime? dateAdded, // ให้ dateAdded เป็น optional
    this.imageUrl,
  }) : dateAdded = dateAdded ?? DateTime.now(); // ค่าเริ่มต้นเป็นวันปัจจุบัน

  // แปลงข้อมูลเป็น Map สำหรับบันทึกลงฐานข้อมูล
  Map<String, dynamic> toMap() {
    return {
      'keyID': keyID,
      'drinkName': drinkName,
      'price': price,
      'category': category,
      'dateAdded': dateAdded.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  // แปลงจาก Map กลับเป็น Object
  factory DrinkMenuItem.fromMap(Map<String, dynamic> map) {
    return DrinkMenuItem(
      keyID: map['keyID'],
      drinkName: map['drinkName'] ?? 'ไม่ระบุชื่อ',
      price: (map['price'] as num).toDouble(), // ป้องกัน null และให้เป็น double เสมอ
      category: map['category'] ?? 'ทั่วไป',
      dateAdded: map['dateAdded'] != null ? DateTime.parse(map['dateAdded']) : DateTime.now(),
      imageUrl: map['imageUrl'],
    );
  }
}
