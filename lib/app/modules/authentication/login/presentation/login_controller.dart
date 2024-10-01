import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error_dialog.dart';
import 'package:shop/app/modules/authentication/login/data/models/login_model.dart';
import 'package:shop/app/utils/log/logger.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';
import 'package:shop/app/utils/pages/app_pages.dart';
import '../data/repository/login_repository.dart';

class LoginController extends GetxController with LoadingMixin {
  final LoginRepository _loginRepository;
  LoginController({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final LoginModel _loginModel = LoginModel();

  final Rx<String?> _emailError = Rx(null);
  String? get emailError => _emailError.value;

  final Rx<String?> _passwordError = Rx(null);
  String? get passwordError => _passwordError.value;

  Rx<String?> error = Rx(null);
  Rx<bool> hasError = Rx(false);

  @override
  void onInit() {
    _addListeners();
    super.onInit();
  }

  void goBack() => Get.back();
  void onSignUpTap() => Get.offNamed(Routes.SIGNUP);
  void hideKeyboard() => _unfocus();

  void emailValidator(String? error) => emailError = error;
  void passwordValidator(String? error) => passwordError = error;
  bool _canRequestLogin() => emailError == null && passwordError == null;

  set emailError(String? error) {
    _emailError.value = error;
  }

  set passwordError(String? error) {
    _passwordError.value = error;
  }

  void onLoginTap() async {
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      if (_canRequestLogin()) {
        await _login();
      } else {}
    } else {}
  }

  Future<void> _login() async {
    final errorOrEither =
        await executeWithLoading(() => _loginRepository.login(_loginModel));
    errorOrEither.fold(
      (error) {
        kErrorDialog(Get.context!, error.toString());
      },
      (either) {
        either.fold(
          (error) {
            kErrorDialog(Get.context!, error.toString());
          },
          (success) {
            Get.back();
          },
        );
      },
    );
  }

  void _emailChange() {
    if (emailController.text.trim().isEmpty) return;
    if (_loginModel.email != emailController.text) {
      _loginModel.email = emailController.text.trim();
      emailError = null;
    }
  }

  void _passwordChange() {
    if (passwordController.text.trim().isEmpty) return;
    if (_loginModel.password != passwordController.text) {
      _loginModel.password = passwordController.text;
      passwordError = null;
    }
  }

  void _unfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void _addListeners() {
    emailController.addListener(_emailChange);
    passwordController.addListener(_passwordChange);
  }

  void _removeListeners() {
    emailController.removeListener(_emailChange);
    passwordController.removeListener(_passwordChange);
  }

  void _clearTextControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void _unfocusNodes() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void _resetErrors() {
    emailError = null;
    passwordError = null;
  }

  void _disposeControllers() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void _resetForm() {
    _resetErrors();
    _removeListeners();
    _clearTextControllers();
    _unfocusNodes();
  }

  @override
  void onClose() {
    _resetForm();
    _disposeControllers();
    super.onClose();
  }
}
