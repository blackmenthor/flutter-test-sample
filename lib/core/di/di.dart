import 'package:dio/dio.dart';
import 'package:flutter_test_sample/core/api/api.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DependencyInjection {

  static void inject() {
    getIt.allowReassignment = true;
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<Api>(Api());
  }

}