import 'package:dio/dio.dart';
import 'package:flutter_test_sample/core/di/di.dart';

class Api {

  final dio = getIt.get<Dio>();

  Future<Map<String, dynamic>?>? get({
    required String url,
  }) async {
    final resp = await dio.get(
      url,
    );
    return resp.data;
  }

}