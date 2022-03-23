import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';



class SendMessages extends StatefulWidget {
  const SendMessages({Key key}) : super(key: key);

  @override
  State<SendMessages> createState() => _SendMessagesState();
}

class _SendMessagesState extends State<SendMessages> {
  final TextEditingController _textmessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Messages'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    'Type Message',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                )),
            InputField(
              maxLength: 1000,
              controller: _textmessage,
              textInputAction: TextInputAction.done,
              minLines: 10,
              inputDecoration: const InputDecoration(
                hintText: 'Enter Message',
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                   SignInButton(
                    text: 'Send',
                    callback: (){
                      Fluttertoast.showToast(msg: 'hello');
                    },
                  ),
                  const SignInButton(
                    text: 'Send To Group',
                  ),
                  SignInButton(
                    text: 'Clear',
                    callback: () => _textmessage.clear(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
