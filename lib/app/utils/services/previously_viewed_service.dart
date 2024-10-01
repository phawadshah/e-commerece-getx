import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/server/firebase_helper.dart';

class PreviouslyViewedService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getItems(String uid) async {
    List<Product> products = <Product>[];
    await _firestore
        .collection(FirebaseConstant.BROWSE_PATH)
        .doc(uid)
        .collection("products")
        .get()
        .then((value) {
      for (var element in value.docs) {
        try {
          products.add(Product.fromJson(element.data()));
        } catch (e) {
          throw SomethingWentWrongException();
        }
      }
    }).catchError((e) {
      throw AppException(e.toString());
    });
    return products;
  }

  Future<void> add(String uid, Product product) async {
    await _firestore
        .collection(FirebaseConstant.BROWSE_PATH)
        .doc(uid)
        .collection("products")
        .doc(product.id.toString())
        .set(product.toMap());
  }
}
