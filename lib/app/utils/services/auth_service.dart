// import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:get/get.dart';
import 'package:shop/app/modules/authentication/login/data/models/login_model.dart';
import 'package:shop/app/modules/authentication/sign_up/data/model/singup_model.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';

/* THIS SERVICE DEALS ONLY WITH AUTHENTICATION OF FIREBASE 
THIS CLASS WILL ONLY BE INITIALIZED ONCE*/

class AuthService extends GetxService {
  final fauth.FirebaseAuth _auth = fauth.FirebaseAuth.instance;

  Stream<fauth.User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<fauth.UserCredential> signInWithEmailAndPassword(
    LoginModel user,
  ) async {
    return await _auth
        .signInWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException();
    });
  }

  Future<fauth.UserCredential> createUserWithEmailAndPassword(
    SingupModel user,
  ) async {
    return await _auth
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException();
    });
  }

  Future<bool> signOut() async {
    await _auth.signOut().timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException();
    });
    return true;
  }

  Future<bool> deleteUser(SingupModel user) async {
    fauth.UserCredential response;
    response = await signInWithEmailAndPassword(
        LoginModel(email: user.email, password: user.password));
    fauth.User? currentUser = response.user;
    if (currentUser != null) {
      currentUser.delete().timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException();
      });
      return true;
    } else {
      return false;
    }
  }
}
