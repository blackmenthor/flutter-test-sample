import 'package:flutter/material.dart';
import 'package:flutter_test_sample/app/app.dart';
import 'package:flutter_test_sample/core/di/di.dart';

void main() {
  DependencyInjection.inject();

  runApp(const MyApp());
}
