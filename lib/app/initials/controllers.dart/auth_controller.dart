import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/server/exceptions/auth_exceptions.dart';
import '../../modules/authentication/login/data/models/login_model.dart';
import '../../modules/authentication/sign_up/data/model/singup_model.dart';
import '../../server/exceptions/app_exceptions.dart';
import '../../utils/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;

  AuthController({
    required AuthService authService,
  }) : _authService = authService;

  final Rx<fauth.User?> _firebaseUser =
      Rx<fauth.User?>(fauth.FirebaseAuth.instance.currentUser);
  fauth.User? get user => _firebaseUser.value;
  RxBool get isAuthenticated => (_firebaseUser.value != null).obs;

  @override
  onInit() {
    _firebaseUser.bindStream(_authService.authStateChanges());
    super.onInit();
  }

  Future<fauth.UserCredential> login(LoginModel user) async {
    try {
      return await _authService.signInWithEmailAndPassword(user);
    } on fauth.FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code, e.message!);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<fauth.UserCredential> singup(SingupModel user) async {
    try {
      return await _authService.createUserWithEmailAndPassword(user);
    } on fauth.FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code, e.message!);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<bool> logout() async {
    try {
      await _authService.signOut();
      clear();
      Get.find<UserController>().clear();
      return true;
    } on fauth.FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code, e.message!);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  void clear() {
    _firebaseUser.value = null;
  }
}
