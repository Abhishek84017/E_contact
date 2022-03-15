import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/auth/signin.dart';
import 'package:widget_of_the_week/screens/addmembers.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const String title = 'E-contact';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(builder: () {
          return child;
        });
      },
      home: const WelcomeScreen(),
    );
  }
}
