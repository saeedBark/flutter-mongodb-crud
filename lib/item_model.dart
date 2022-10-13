import 'dart:convert';

class Item {
  String id;
  String name;
  int qty;
  String details;
  Item({
    required this.id,
    required this.name,
    required this.qty,
    required this.details,
  });

  Item.forMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        qty = map['qty'],
        details = map['descrption'];

  Item copyWith({
    String? id,
    String? name,
    int? qty,
    String? details,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qty': qty,
      'details': details,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      qty: map['qty'] as int,
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, qty: $qty, details: $details)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.qty == qty &&
        other.details == details;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ qty.hashCode ^ details.hashCode;
  }
}
