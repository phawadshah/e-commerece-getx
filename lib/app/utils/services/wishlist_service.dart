import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/server/firebase_helper.dart';

class WishlistService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<int>> getItems(String uid) async {
    List<int> products = <int>[];
    await _firestore
        .collection(FirebaseConstant.WISHLIST_PATH)
        .doc(uid)
        .collection("products")
        .get()
        .then((value) {
      for (var element in value.docs) {
        try {
          products.add(element.data()["productId"]);
        } catch (e) {
          throw SomethingWentWrongException();
        }
      }
    }).catchError((e) {
      throw AppException(e.toString());
    });
    return products;
  }

  Future<void> addProduct(String uid, int productId) async {
    await _firestore
        .collection(FirebaseConstant.WISHLIST_PATH)
        .doc(uid)
        .collection("products")
        .doc(productId.toString())
        .set({"productId": productId});
  }

  Future<void> removeProduct(String uid, int productId) async {
    await _firestore
        .collection(FirebaseConstant.WISHLIST_PATH)
        .doc(uid)
        .collection("products")
        .doc(productId.toString())
        .delete();
  }
}
