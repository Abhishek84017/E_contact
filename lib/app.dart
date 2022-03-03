import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/screens/homepage.dart';
import 'package:widget_of_the_week/screens/profile.dart';
import 'pages/auth/signin.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const String title = 'E-contact';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
    //  theme: ThemeData.from(colorScheme:  ColorScheme.fromSwatch(primarySwatch: Colors.red),textTheme: TextTheme(headline1: TextStyle(color: Colors.red))),
      builder: (context, child) {
        return ScreenUtilInit(builder: () {
          return child;
        });
      },
      home: const MyProfile(),
    );
  }
}
