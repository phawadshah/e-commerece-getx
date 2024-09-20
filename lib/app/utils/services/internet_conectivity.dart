import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity extends GetxService {
  final RxBool _isConnected = false.obs;
  bool get isConnected => _isConnected.value;

  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  void onInit() async {
    await _checkConnection();
    _registerListener();
    super.onInit();
  }

  Future<void> _checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    _isConnected.value = connectivityResult[0] != ConnectivityResult.none;
  }

  void _registerListener() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _isConnected.value = result[0] != ConnectivityResult.none;
    });
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
