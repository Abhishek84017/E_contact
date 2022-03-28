import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:widget_of_the_week/constant/globle.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:widget_of_the_week/screens/homepage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin
{

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _usernameAdmin = TextEditingController();
  final TextEditingController _passwordAdmin = TextEditingController();
  bool isLoading = true;
  bool _isLoadingAdmin = true;

  Future _signInMember() async {
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
          Navigator.push(context, CupertinoPageRoute(builder: (context) => HomePage(mobile: _username.text)));
          await kSharedPreferences.setBool('loginData', true);
        }
        _username.clear();
        _password.clear();
        setState(() {
          isLoading = true;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Connection required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }


  Future _signInAdmin() async {
    var data = <String, dynamic>{
      "username": _usernameAdmin.text,
      "password": _passwordAdmin.text,
    };
    final response = await http.post(
        Uri.https('econtact.votersmanagement.com', 'api/check-admin-login'), body: data);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: jsonData["message"]);
        if (response.statusCode == 200) {
          await kSharedPreferences.setBool('Admin', true);
          await kSharedPreferences.setBool('loginData', true);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const HomePage()));
        }
        _usernameAdmin.clear();
        _passwordAdmin.clear();

        setState(() {
          _isLoadingAdmin = true;
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
        body: SingleChildScrollView(
          child: _tabSection(),
        ),
      ),
    );
  }

  Widget _tabSection() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.blue),
              ),
              child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue),
                  labelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Member',
                    ),
                    Tab(
                      text: 'Admin',
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome! Member',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
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
                  SizedBox(
                    height: 5.h,
                  ),
                  isLoading
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
                              isLoading = false;
                            });
                            _signInMember();
                          },
                        )
                      : const CircularIndicator(),
                ],
              ),
               Column(
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
                    _isLoadingAdmin
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
                          _isLoadingAdmin = false;
                        });
                        _signInAdmin();
                      },
                    )
                        : const CircularIndicator(),
                  ],
              )
            ]
            ),
          ),
        ],
      ),
    );
  }
}
