// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class EnvService extends GetxService {
  late String _baseUrl;
  String get baseUrl => _baseUrl;

  @override
  void onInit() async {
    super.onInit();
    await _loadEnv();
  }

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: EnvConstants.FILE_NAME);
    _populateEnv();
  }

  void _populateEnv() {
    _baseUrl = dotenv.get(EnvConstants.BASE_URL, fallback: "");
  }
}

class EnvConstants {
  static const String BASE_URL = 'BASE_URL';
  static const String FILE_NAME = '.env';
}
