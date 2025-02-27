class DrinkMenuItem {
  int? keyID;
  String drinkName;
  double price;
  String category;
  DateTime dateAdded;
  String? imageUrl;
  String description; // ✅ เพิ่มฟิลด์รายละเอียดเครื่องดื่ม

  DrinkMenuItem({
    this.keyID,
    required this.drinkName,
    required this.price,
    required this.category,
    required this.description, // ✅ กำหนดค่า required
    DateTime? dateAdded,
    this.imageUrl,
  }) : dateAdded = dateAdded ?? DateTime.now();

  // แปลงข้อมูลเป็น Map
  Map<String, dynamic> toMap() {
    return {
      'keyID': keyID,
      'drinkName': drinkName,
      'price': price,
      'category': category,
      'dateAdded': dateAdded.toIso8601String(),
      'imageUrl': imageUrl,
      'description': description, // ✅ เพิ่มฟิลด์ description
    };
  }

  // แปลงจาก Map กลับเป็น Object
  factory DrinkMenuItem.fromMap(Map<String, dynamic> map) {
    return DrinkMenuItem(
      keyID: map['keyID'],
      drinkName: map['drinkName'] ?? 'ไม่ระบุชื่อ',
      price: (map['price'] as num).toDouble(),
      category: map['category'] ?? 'ทั่วไป',
      description: map['description'] ?? '', // ✅ รองรับ description
      dateAdded: map['dateAdded'] != null ? DateTime.parse(map['dateAdded']) : DateTime.now(),
      imageUrl: map['imageUrl'],
    );
  }
}
