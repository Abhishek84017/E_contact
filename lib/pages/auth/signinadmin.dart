import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/auth/signin.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
class SignInMember extends StatefulWidget {
  const SignInMember({Key key}) : super(key: key);

  @override
  State<SignInMember> createState() => _SignInMemberState();
}

class _SignInMemberState extends State<SignInMember> {
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
            inputDecoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
          InputField(
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
          SignInButton(
            width: 0.95.sw,
            text: 'Login In',
          ),
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const WelcomeScreen() ));
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
