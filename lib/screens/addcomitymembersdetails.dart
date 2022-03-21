import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class AddComityMemberDetail extends StatefulWidget {
  const AddComityMemberDetail({Key key}) : super(key: key);

  @override
  State<AddComityMemberDetail> createState() => _AddComityMemberDetailState();
}

class _AddComityMemberDetailState extends State<AddComityMemberDetail> {
  bool _isLoading = true;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  Future _addMemberDetail() async {
    var data = <String, dynamic>{
      "committee": "1",
      "name": _name.text,
      "mobile": _mobile.text,
    };
    final response = await http.post(
        Uri.https('econtact.votersmanagement.com', 'api/add-contacts'),
        body: data);
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: jsonData['message']);
        _name.clear();
        _mobile.clear();
         setState(() {
           _isLoading = true;
         });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Connection required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went Wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            controller: _name,
            inputDecoration: const InputDecoration(hintText: 'Name'),
          ),
          InputField(
            controller: _mobile,
            inputDecoration: const InputDecoration(hintText: 'Mobile No'),
            keyboardType: TextInputType.number,
          ),
          _isLoading == true
              ? SignInButton(
                  text: 'Add Member Detail',
                  width: 0.95.sw,
                  callback: () {
                    if (_name.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Name Required');
                      return;
                    }
                    if (_mobile.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Name Required');
                      return;
                    }
                    if(!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(_mobile.text))
                    {
                      Fluttertoast.showToast(msg: 'Invalid Mobile Number');
                      return;
                    }
                    setState(() {
                      _isLoading = false;
                    });
                    _addMemberDetail();
                  },
                )
              : const CircularIndicator(),
        ],
      ),
    );
  }
}
