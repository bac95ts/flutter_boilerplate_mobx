import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_project/di/service_locator.dart';
import 'package:flutter_boilerplate_project/presentation/my_app.dart';

Future<void> main() async {
  await ServiceLocator.configureDependencies();
  runApp(const MyApp());
}
