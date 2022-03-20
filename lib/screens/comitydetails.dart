import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/screens/addcomity.dart';
import 'package:widget_of_the_week/screens/comitymemberdetails.dart';

class ComityDetailsModel {
  int id;
  String title;
  String logo;
  String insertedIp;

  ComityDetailsModel({this.id, this.title, this.logo, this.insertedIp});

  ComityDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    logo = json['logo'];
    insertedIp = json['inserted_ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['logo'] = logo;
    data['inserted_ip'] = insertedIp;
    return data;
  }
}

class ComityDetails extends StatefulWidget {
  const ComityDetails({Key key}) : super(key: key);

  @override
  State<ComityDetails> createState() => _ComityDetailsState();
}

class _ComityDetailsState extends State<ComityDetails> {
  bool _isLoading = true;
  List<ComityDetailsModel> comityDetail = <ComityDetailsModel>[];

  Future _getComityDetails() async {
    print('hello');
    final response = await http.get(Uri.parse(
        'https://econtact.votersmanagement.com/api/get-all-committee'));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            comityDetail.add(ComityDetailsModel.fromJson(v));
          });
          setState(() {
            _isLoading = false;
          });
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getComityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comity Details'),
      ),
      body: _isLoading
          ? const CircularIndicator()
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: comityDetail.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
                          crossAxisSpacing: 1.w,
                          mainAxisSpacing: 1.w,
                          childAspectRatio: (2 / 1.3)),
                      itemBuilder: (context, index) {
                        var item = comityDetail[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => const ComityMemberDetails() )),
                            child: Card(
                              shadowColor: Colors.white,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.group),
                                  Text(item.title),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SignInButton(
                  text: 'Add Comity',
                  width: 0.95.sw,
                  callback: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddComity()));
                  },
                )
              ],
            ),
    );
  }
}
