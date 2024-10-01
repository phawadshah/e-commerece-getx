import 'package:cloud_firestore/cloud_firestore.dart' as fstore;
import 'package:get/get.dart';
import 'package:shop/app/modules/authentication/data/models/user.dart';
import 'package:shop/app/server/firebase_helper.dart';
import '../../server/exceptions/app_exceptions.dart';

/* THIS CLASS ONLY DEALS WITH FIREBASE DATABASE
THIS CLASS WILL ONLY BE INITIALIZED ONCE 
THIS CLASS WILL HAVE ONLY ONE INSTANCE */
class UserService extends GetxService {
  final fstore.FirebaseFirestore _firestore = fstore.FirebaseFirestore.instance;

  Future<bool> setNewUser(User user) async {
    await _firestore
        .collection(FirebaseConstant.USER_PATH)
        .doc(user.id)
        .set(user.toMap())
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException();
    });
    return true;
  }

  Future<fstore.DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return await _firestore
        .collection(FirebaseConstant.USER_PATH)
        .doc(uid)
        .get()
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException();
    });
  }
}
