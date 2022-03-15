import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:widget_of_the_week/pages/auth/signinadmin.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:widget_of_the_week/screens/homepage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isloading = true;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
   String userName;

  Future _SignInMember() async {
    userName = _username.text;
    var data = <String, dynamic>{
      "username": _username.text,
      "password": _password.text,
    };
    final response = await http.post(
        Uri.https('econtact.votersmanagement.com', 'api/check-member-login'),
        body: data);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: jsonData["message"]);
        if (response.statusCode == 200) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage(mobile: userName)));
        }
        _username.clear();
        _password.clear();
        setState(() {
          isloading = true;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Connection required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome! Member',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            ),
            InputField(
              controller: _username,
              inputDecoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(
                  Icons.email,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
            InputField(
              controller: _password,
              inputDecoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
            /* Padding(
              padding: EdgeInsets.only(right: 12.w),
              child:  Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),*/
            SizedBox(
              height: 5.h,
            ),
            isloading
                ? SignInButton(
                    width: 0.95.sw,
                    text: 'Login In',
                    callback: () {
                      if (_username.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Username required');
                        return;
                      }
                      if (_password.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Password required');
                        return;
                      }
                      setState(() {
                        isloading = false;
                      });
                      _SignInMember();
                    },
                  )
                : const CircularIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Have an Account As?',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SignInMember()));
                    },
                    child: Text(
                      'Admin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
