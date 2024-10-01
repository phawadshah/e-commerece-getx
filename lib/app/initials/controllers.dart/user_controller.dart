import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../modules/authentication/data/models/user.dart';
import '../../utils/log/logger.dart';
import '../../utils/services/user_service.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  final UserService _userService;
  final AuthController _authController;
  UserController({
    required UserService userService,
    required AuthController authController,
  })  : _userService = userService,
        _authController = authController;

  final Rx<User> _user = User().obs;
  User get user => _user.value;
  set user(User value) => _user.value = value;

  @override
  void onInit() {
    if (_authController.user != null) {
      getUser(_authController.user!.uid).then((value) {
        user = value;
      });
    }
    super.onInit();
  }

  Future<bool> createNewUser(User user) async {
    return await _userService.setNewUser(user);
  }

  Future<User> getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> results =
        await _userService.getUser(uid);
    return User.fromDocumentSnapShot(results);
  }

  void clear() {
    KLogger.debug("user clear called");
    _user.value = User();
  }
}
