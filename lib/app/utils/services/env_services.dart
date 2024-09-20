import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class EnvServices extends GetxService {
  late String _baseUrl;
  String get baseUrl => _baseUrl;

  Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
    _populateEnv();
  }

  void _populateEnv() {
    _baseUrl = dotenv.get(EnvConstants.BASE_URL, fallback: "");
  }
}

class EnvConstants {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'BASE_URL';
}
