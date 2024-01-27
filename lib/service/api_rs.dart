import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_obat/model/rs_model.dart';
import 'dart:convert';

class ApiRS {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-obat-409909.cloudfunctions.net';

  Future<Iterable<RSModel>?> getAllRS() async {
    try {
      var response = await dio.get('$_baseUrl/rs');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);

        final rsList =
            (datas['data'] as List).map((rs) => RSModel.fromJson(rs)).toList();
        return rsList;
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

  Future<RSModel?> getSingleRS(String id) async {
    try {
      var response = await dio.get('$_baseUrl/rs?_id=$id');
      if (response.statusCode == 200) {
        debugPrint('respon: ${response.data}');
        final data = json.decode(response.data);
        return RSModel.fromJson(data['data']);
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

  Future<RSResponse?> postRS(RSInput rs) async {
    try {
      final response = await dio.post(
        '$_baseUrl/rs',
        data: rs.formData(),
      );
      if (response.statusCode == 200) {
        return RSResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<RSResponse?> putRS(String id, RSInput rs) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/rs?_id=$id',
        data: rs.formData(),
      );
      if (response.statusCode == 200) {
        return RSResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRS(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/rs?_id=$id');
      if (response.statusCode == 200) {
        return RSResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
