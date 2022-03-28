import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/constant/globle.dart';
import 'package:widget_of_the_week/pages/auth/Welcomepage.dart';
import 'package:widget_of_the_week/screens/homepage.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static const String title = 'E-contact';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool finaLoginData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValidationData();
  }

  Future getValidationData()async{
    var validationData = kSharedPreferences.getBool('loginData');
    setState(() {
      finaLoginData = validationData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.title,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(builder: () {
          return child;
        });
      },
      home: finaLoginData == true ? const HomePage() : const WelcomeScreen(),
    );
  }
}
