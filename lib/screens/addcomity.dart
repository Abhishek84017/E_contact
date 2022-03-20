import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddComity extends StatefulWidget {
  const AddComity({Key key}) : super(key: key);

  @override
  State<AddComity> createState() => _AddComityState();
}

class _AddComityState extends State<AddComity> {
  bool _isLoading = true;
  final TextEditingController _title = TextEditingController();

  Future _addComity() async {
    var data = <String, dynamic>{
      "title": _title.text,
      "logo": "assets/admin/images/20220316104648.png",
      "inserted_ip": "49.36.95.131"
    };
    final reponse = await http.post(
        Uri.https('econtact.votersmanagement.com', 'api/add-committee'),
        body: data);
     print(reponse.statusCode);
     print(reponse.request);
    try {
      if (reponse.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Comity Added');
        setState(() {
          _isLoading = true;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Not Connected');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    //s_isLoading = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comity'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            controller: _title,
            inputDecoration: const InputDecoration(hintText: 'Title'),
          ),
          _isLoading
              ? SignInButton(
                  text: 'Add Comity',
                  width: 0.75.sw,
                  callback: () {
                    setState(() {
                      _isLoading = false;
                    });
                    _addComity();
                  },
                )
              : const CircularIndicator(),
        ],
      ),
    );
  }
}
