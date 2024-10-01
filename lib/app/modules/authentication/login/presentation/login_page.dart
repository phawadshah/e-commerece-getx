import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/button.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/utils/helper.dart';
import 'package:shop/app/utils/validators/validators.dart';

import '../../../../common/widgets/textField.dart';
import '../../../../utils/constants/enums.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: controller.hideKeyboard,
        child: Stack(
          children: [
            _buildView(),
            Obx(
              () => controller.state == ControllerState.LOADING
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black26,
                    )
                  : const KEmptyWidget(),
            ),
          ],
        ),
      ),
    );
  }

  SafeArea _buildView() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: controller.goBack,
                icon: const Icon(Icons.clear),
              ),
            ),
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const Text(
              "Believe us! We missed you",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            addVerticleSpace(20),
            Obx(
              () => Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    KTextField(
                      label: "Email",
                      controller: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      errorMessage: controller.emailError,
                      validator: (email) {
                        controller.emailValidator
                            .call(KValidators.validateEmail(email));
                        return null;
                      },
                    ),
                    addVerticleSpace(20),
                    KPasswordField(
                      label: "Password",
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      errorMessage: controller.passwordError,
                      validator: (password) {
                        controller.passwordValidator
                            .call(KValidators.validateLoginPassword(password));
                        return null;
                      },
                    ),
                    addVerticleSpace(40),
                    SizedBox(
                      height: 56,
                      width: Get.width,
                      child: KButton(
                        title: "Login",
                        onTap: controller.onLoginTap,
                        state: controller.state,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            addVerticleSpace(10),
            Text.rich(TextSpan(children: [
              const TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "Sign Up",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = controller.onSignUpTap,
              )
            ])),
          ],
        ),
      ),
    );
  }
}
