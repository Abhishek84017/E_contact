import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/constant/globle.dart';
import 'package:widget_of_the_week/pages/auth/signin.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:widget_of_the_week/screens/homepage.dart';

class SignInMember extends StatefulWidget {
  const SignInMember({Key key}) : super(key: key);

  @override
  State<SignInMember> createState() => _SignInMemberState();
}

class _SignInMemberState extends State<SignInMember> {
  bool _isloading = true;

  final TextEditingController _usernameAdmin = TextEditingController();
  final TextEditingController _passwordAdmin = TextEditingController();

  Future _SignInAdmin() async {
    var data = <String, dynamic>{
      "username": _usernameAdmin.text,
      "password": _passwordAdmin.text,
    };
    final response = await http.post(
        Uri.https('econtact.votersmanagement.com', 'api/check-admin-login'), body: data);
    print(response.statusCode);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: jsonData["message"]);
        if (response.statusCode == 200) {
          await kSharedPreferences.setBool('Admin', true);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const HomePage()));
        }

        setState(() {
          _isloading = true;
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome! Admin',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
          ),
          InputField(
            controller: _usernameAdmin,
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
            controller: _passwordAdmin,
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
          SizedBox(
            height: 5.h,
          ),
          _isloading
              ? SignInButton(
                  width: 0.95.sw,
                  text: 'Login In',
                  callback: () {
                    if (_usernameAdmin.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Username required');
                      return;
                    }
                    if (_passwordAdmin.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Password required');
                      return;
                    }
                    setState(() {
                      _isloading = false;
                    });
                    _SignInAdmin();
                  },
                )
              : const CircularIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Have an Account As?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
              SizedBox(
                width: 2.w,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const WelcomeScreen()));
                    setState(() {});
                  },
                  child: Text(
                    'Member',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.blue),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
