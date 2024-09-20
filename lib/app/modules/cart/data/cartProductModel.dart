// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

import 'package:shop/app/modules/home/data/models/product.dart';

class CartProductModel {
  final Product product;
  int quantity;
  CartProductModel({
    required this.product,
    required this.quantity,
  });

  CartProductModel copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartProductModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      product: Product.fromJson(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Cartproductmodel(product: $product, quantity: $quantity)';

  @override
  bool operator ==(covariant CartProductModel other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
