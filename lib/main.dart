import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/globle.dart';

Future<void>  main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  kSharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}


