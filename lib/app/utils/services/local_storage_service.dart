// ignore_for_file: constant_identifier_names

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

  // Future<LocalStorageService> initStorage() async {
  //   return this;
  // }

  Future<void> write<T>({required String key, required T data}) async {
    return await _storage.write(key, data);
  }

  T? read<T>({required String key}) {
    return _storage.read<T?>(key);
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
