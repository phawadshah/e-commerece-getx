import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/app/server/firebase_helper.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';

import '../../modules/home/data/models/product.dart';
import 'data/models/product_storage_model.dart';

class CartService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalStorageService _localStorageService;

  CartService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  Future<void> updateCartLocally(List<ProductStorageModel> items) async {
    return await _localStorageService.write(
      key: StorageConstants.CART,
      data: List<dynamic>.from(
        items.map((x) => x.toJson()),
      ),
    );
  }

  Future<void> addItemToFirebase(Product product, {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  Future<void> removeItemFromFirebase(Product product,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .delete();
  }

  Future<void> updateItemInFirebase(Product product,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .update(product.toMap());
  }

  Future<void> addListToFirebase(List<ProductStorageModel> items,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .set({"products": List<dynamic>.from(items.map((x) => x.toJson()))});
  }
}
