import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class SendWhatsappMessage extends StatefulWidget {
  const SendWhatsappMessage({Key key}) : super(key: key);

  @override
  State<SendWhatsappMessage> createState() => _SendWhatsappMessageState();
}

class _SendWhatsappMessageState extends State<SendWhatsappMessage> {
  final TextEditingController _textmessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Whatsapp Messages'),
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
            Row(
              children: [
                const SignInButton(
                  text: 'Send',
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
          ],
        ),
      ),
    );
  }
}
