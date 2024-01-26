import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_obat/model/obat_model.dart';
import 'dart:convert';

class ApiObat {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-obat-409909.cloudfunctions.net';

  Future<Iterable<ObatModel>?> getAllObat() async {
    try {
      var response = await dio.get('$_baseUrl/obat');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);

        final obatList = (datas['data'] as List)
            .map((obat) => ObatModel.fromJson(obat))
            .toList();
        return obatList;
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

  Future<ObatModel?> getSingleObat(String id) async {
    try {
      var response = await dio.get('$_baseUrl/obat?_id=$id');
      if (response.statusCode == 200) {
        debugPrint('respon: ${response.data}');
        final data = json.decode(response.data);
        return ObatModel.fromJson(data['data']);
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

  Future<ObatResponse?> postObat(ObatInput obat) async {
    try {
      final response = await dio.post(
        '$_baseUrl/obat',
        data: obat.formData(),
      );
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        return ObatResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<ObatResponse?> putObat(String id, ObatInput obat) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/obat?_id=$id',
        data: obat.formData(),
      );
      if (response.statusCode == 200) {
        return ObatResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteObat(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/obat?_id=$id');
      if (response.statusCode == 200) {
        return ObatResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>?> getAllObatNames() async {
    try {
      var response = await dio.get('$_baseUrl/obat');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);
        if (datas['data'] is List) {
          final obatList = (datas['data'] as List)
              .map((obat) => ObatModel.fromJson(obat).namaObat)
              .toList();
          return obatList;
        } else {
          debugPrint('Unexpected data format in the response');
          return null;
        }
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
}
