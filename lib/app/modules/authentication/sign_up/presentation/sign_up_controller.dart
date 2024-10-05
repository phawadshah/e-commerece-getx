import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error_dialog.dart';
import 'package:shop/app/common/widgets/snackbar.dart';
import 'package:shop/app/modules/authentication/sign_up/data/model/singup_model.dart';
import 'package:shop/app/modules/authentication/sign_up/data/repository/signup_repository.dart';
import 'package:shop/app/server/exceptions/auth_exceptions.dart';
import 'package:shop/app/utils/pages/app_pages.dart';
import '../../../../utils/mixins/loading_mixin.dart';

class SignUpController extends GetxController with LoadingMixin {
  final SignupRepository _signupRepository;
  SignUpController({required SignupRepository signupRepository})
      : _signupRepository = signupRepository;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final SingupModel _singupModel = SingupModel();
  SingupModel get singupModel => _singupModel;

  final Rx<String?> _nameError = Rx(null);
  String? get nameError => _nameError.value;

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
  void hideKeyboard() => _unfocus();
  void onLoginTap() => Get.offNamed(Routes.LOGIN);

  void nameValidator(String? error) => nameError = error;
  void emailValidator(String? error) => emailError = error;
  void passwordValidator(String? error) => passwordError = error;

  bool _canRequestSignup() =>
      nameError == null && emailError == null && passwordError == null;

  set nameError(String? error) {
    _nameError.value = error;
  }

  set emailError(String? error) {
    _emailError.value = error;
  }

  set passwordError(String? error) {
    _passwordError.value = error;
  }

  void onSignUpTap() async {
    final form = signUpFormKey.currentState!;
    if (form.validate()) {
      if (_canRequestSignup()) {
        await _signup();
      } else {}
    } else {}
  }

  Future<void> _signup() async {
    final errorOrEither =
        await executeWithLoading(() => _signupRepository.singUp(singupModel));
    errorOrEither.fold(
      (error) {
        error is AuthExceptions && error.code == 'email-already-in-use'
            ? emailError = error.message
            : kErrorDialog(Get.context!, error.toString());
      },
      (either) {
        either.fold(
          (error) {
            kErrorDialog(Get.context!, error.toString());
          },
          (success) {
            Get.back();
            KSnackbar.successSnackbar(
                title: "Welcom! Account created successfully");
          },
        );
      },
    );
  }

  void _nameChange() {
    if (nameController.text.trim().isEmpty) return;
    if (_singupModel.name != nameController.text.trim()) {
      _singupModel.name = nameController.text.trim();
      nameError = null;
    }
  }

  void _emailChange() {
    if (emailController.text.trim().isEmpty) return;
    if (_singupModel.email != emailController.text) {
      _singupModel.email = emailController.text.trim();
      emailError = null;
    }
  }

  void _passwordChange() {
    if (passwordController.text.trim().isEmpty) return;
    if (_singupModel.password != passwordController.text) {
      _singupModel.password = passwordController.text;
      passwordError = null;
    }
  }

  void _unfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void _addListeners() {
    nameController.addListener(_nameChange);
    emailController.addListener(_emailChange);
    passwordController.addListener(_passwordChange);
  }

  void _removeListeners() {
    nameController.removeListener(_nameChange);
    emailController.removeListener(_emailChange);
    passwordController.removeListener(_passwordChange);
  }

  void _clearTextControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void _unfocusNodes() {
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void _resetErrors() {
    nameError = null;
    emailError = null;
    passwordError = null;
  }

  void _disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
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
