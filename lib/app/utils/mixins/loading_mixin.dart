import 'dart:async';

import 'package:get/get.dart';
import 'package:shop/app/utils/constants/enums.dart';

mixin LoadingMixin on GetxController {
  final Rx<ControllerState> _state = ControllerState.IDLE.obs;
  ControllerState get state => _state.value;
  set state(ControllerState status) => _state.value = status;

  void showLoader() => state = ControllerState.LOADING;
  void hideLoader() => state = ControllerState.IDLE;
  FutureOr<T> executeWithLoading<T>(FutureOr<T> Function() action,
      {Duration delay = const Duration(seconds: 0)}) async {
    showLoader();
    try {
      return await Future.delayed(delay).then((_) async => await action());
    } finally {
      hideLoader();
    }
  }
}
