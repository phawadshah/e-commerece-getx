// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'exceptions/app_exceptions.dart';

class ApiBaseHelper extends GetxService {
  http.Client client = http.Client();

  Future request(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    http.Response response;
    try {
      response = await client.get(url, headers: headers);
    } on SocketException {
      throw FetchDataException();
    } on http.ClientException catch (e) {
      throw ApiConnectionException(e.message);
    } catch (e) {
      rethrow;
    }
    await _handleResponse(response);
    final responseJson = json.decode(response.body.toString());
    return (responseJson);
  }

  Future<void> _handleResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return;
      case 400:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException();
    }
  }
}
