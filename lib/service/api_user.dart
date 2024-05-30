import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_obat/model/user_model.dart';
import 'dart:convert';

class ApiUser {
  final Dio dio = Dio();
  final String _baseUrl = 'https://vercel-obat.vercel.app';

  Future<Iterable<UserModel>?> getAllUser() async {
    try {
      var response = await dio.get('$_baseUrl/user');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);

        final userList = (datas['data'] as List)
            .map((user) => UserModel.fromJson(user))
            .toList();
        return userList;
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return null;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/login',
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

  Future<RegisterResponse?> register(RegisterInput register) async {
    try {
      final response = await dio.post(
        '$_baseUrl/register',
        data: register.toJson(),
      );
      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(json.decode(response.data));
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        final data = json.decode(e.response!.data);
        return RegisterResponse.fromJson(data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
