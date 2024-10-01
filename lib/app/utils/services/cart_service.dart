import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/app/server/firebase_helper.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';
import '../../server/exceptions/app_exceptions.dart';

class CartService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final LocalStorageService _localStorageService;

  CartService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  List<dynamic> getItemsFromLocalStorage() {
    final data = _localStorageService.read(key: StorageConstants.CART);
    if (data != null) {
      return (data as List<dynamic>)
          .map((e) => StorageProduct.fromJson(e))
          .toList();
    } else {
      return <StorageProduct>[];
    }
  }

  Future<List<StorageProduct>> getItemsFromFirebase(String uid) async {
    List<StorageProduct> products = <StorageProduct>[];
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection("products")
        .get()
        .then((value) {
          for (var element in value.docs) {
            try {
              products.add(StorageProduct.fromMap(element.data()));
            } catch (e) {
              throw SomethingWentWrongException();
            }
          }
        })
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException(),
        )
        .catchError((e) {
          throw AppException(e.toString());
        });
    return products;
  }

  Future<void> updateCartLocally(List<StorageProduct> items) async {
    return await _localStorageService.write(
      key: StorageConstants.CART,
      data: List<dynamic>.from(
        items.map((x) => x.toJson()),
      ),
    );
  }

  Future<void> clearLocalStorage() async {
    await _localStorageService.delete(key: StorageConstants.CART);
  }

  Future<void> addItemToFirebase(StorageProduct product,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  Future<void> removeItemFromFirebase(StorageProduct product,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .delete();
  }

  Future<void> updateItemInFirebase(StorageProduct product,
      {required String uid}) async {
    await _firestore
        .collection(FirebaseConstant.CART_PATH)
        .doc(uid)
        .collection('products')
        .doc(product.id.toString())
        .update(product.toMap());
  }

  Future<void> addListToFirebase(List<StorageProduct> items,
      {required String uid}) async {
    for (var item in items) {
      await addItemToFirebase(item, uid: uid);
    }
  }
}
