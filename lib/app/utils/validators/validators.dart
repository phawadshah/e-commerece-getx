import '../constants/error_texts.dart';

class KValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationErrors.nameIsRequired;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationErrors.emailIsRequired;
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return ValidationErrors.pleaseEnterAValidEmail;
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationErrors.passwordIsRequired;
    }
    return null;
  }

  static String? validateSingupPassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationErrors.passwordIsRequired;
    }

    if (value.length < 8) {
      return ValidationErrors.passwordMustBeAtLeast8CharactersLong;
    }

    // check for upercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return ValidationErrors.passwordMustContainAtLeastOneUppercaseLetter;
    }

    // check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return ValidationErrors.passwordMustContainAtLeastOneNumber;
    }

    return null;
  }
}
