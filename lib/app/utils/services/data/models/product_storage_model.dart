import 'dart:convert';

class ProductStorageModel {
  final int id;
  final double price;
  int quantity;
  ProductStorageModel({
    required this.id,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ProductStorageModel.fromMap(Map<String, dynamic> map) {
    return ProductStorageModel(
      id: map['id'] as int,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductStorageModel.fromJson(String source) =>
      ProductStorageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
