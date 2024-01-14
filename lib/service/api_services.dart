import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_obat/model/login_model.dart';
import 'dart:convert';

class ApiServices {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-obat-409909.cloudfunctions.net';

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/user',
        data: login.toJson(),
      );

      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.data}');
        return LoginResponse.fromJson(json.decode(response.data));
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return LoginResponse.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
