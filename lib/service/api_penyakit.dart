import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_obat/model/penyakit_model.dart';
import 'dart:convert';

class ApiPenyakit {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-obat-409909.cloudfunctions.net';

  Future<Iterable<PenyakitModel>?> getAllPenyakit() async {
    try {
      var response = await dio.get('$_baseUrl/penyakit');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);
        if (datas['data'] is List) {
          final penyakitList = (datas['data'] as List)
              .map((penyakit) => PenyakitModel.fromJson(penyakit))
              .toList();
          return penyakitList;
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

  Future<PenyakitModel?> getSinglePenyakit(String id) async {
    try {
      var response = await dio.get('$_baseUrl/penyakit?_id=$id');
      if (response.statusCode == 200) {
        debugPrint('respon: ${response.data}');
        final data = json.decode(response.data);
        return PenyakitModel.fromJson(data['data']);
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

  Future<PenyakitResponse?> postPenyakit(PenyakitInput penyakit) async {
    try {
      final response = await dio.post(
        '$_baseUrl/penyakit',
        data: penyakit.toJson(),
      );
      if (response.statusCode == 200) {
        return PenyakitResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<PenyakitResponse?> putPenyakit(
      String id, PenyakitInput penyakit) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/penyakit?_id=$id',
        data: penyakit.toJson(),
      );
      if (response.statusCode == 200) {
        return PenyakitResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deletePenyakit(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/penyakit?_id=$id');
      if (response.statusCode == 200) {
        return PenyakitResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
