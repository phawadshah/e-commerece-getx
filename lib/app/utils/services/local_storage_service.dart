// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageService extends GetxService {
  late GetStorage _storage;

  @override
  void onInit() async {
    await GetStorage.init();
    _storage = GetStorage();
    super.onInit();
  }

  Future<void> write<T>({required String key, required T data}) async {
    return await _storage.write(key, data);
  }

  T? read<T>({required String key}) {
    return _storage.read<T?>(key);
  }

  bool getBool({required String key}) {
    return _storage.read<bool>(key) ?? false;
  }

  Future<void> delete({required String key}) async {
    return await _storage.remove(key);
  }
}

class StorageConstants {
  static const String WISHLIST = "wishlist";
  static const String CART = "cart";
  static const String PREVIOUSSEARCHES = "previousSearches";
}

class StorageProduct {
  final int id;
  final double price;
  int quantity;
  StorageProduct({
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

  factory StorageProduct.fromMap(Map<String, dynamic> map) {
    return StorageProduct(
      id: map['id'] as int,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StorageProduct.fromJson(String source) =>
      StorageProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
