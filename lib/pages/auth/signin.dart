import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom:20.h),
              child: Align(
                  child: Text(
                'Welcome!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              )),
            ),
            const InputField(),
            const InputField(
              textInputAction: TextInputAction.done,
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
            ),
            const SignInButton(
              text: 'Login In',
            )
          ],
        ),
      ),
    );
  }
}
