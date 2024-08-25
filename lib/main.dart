import 'package:checklistapp/app.dart';
import 'package:checklistapp/helper/app_initializers.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializers.init();
  runApp(const App());
}
