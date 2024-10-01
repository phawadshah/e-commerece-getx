// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addItem<T>(
    T item,
    String collectionPath, {
    required String uid,
    String? itemId,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      itemId != null
          ? await _firestore
              .collection(collectionPath)
              .doc(uid)
              .collection("products")
              .doc(itemId)
              .set(toMap(item))
          : await _firestore
              .collection(collectionPath)
              .doc(uid)
              .set(toMap(item));
    } catch (e) {
      throw Exception("Error adding item: $e");
    }
  }
}

class FirebaseConstant {
  static const String USER_PATH = "Users";
  static const String BROWSE_PATH = "Browse_Items";
  static const String CART_PATH = "Cart";
  static const String WISHLIST_PATH = "Wishlist";
}
