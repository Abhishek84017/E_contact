import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/screens/addcomitymembersdetails.dart';
import 'package:http/http.dart' as http;

class ComityMemberDetailsModel {
  int id;
  int committeeId;
  String name;
  String mobile;
  String insertedIp;

  ComityMemberDetailsModel(
      {this.id, this.committeeId, this.name, this.mobile, this.insertedIp});

  ComityMemberDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    committeeId = json['committee_id'];
    name = json['name'];
    mobile = json['mobile'];
    insertedIp = json['inserted_ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['committee_id'] = this.committeeId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['inserted_ip'] = this.insertedIp;
    return data;
  }
}

class ComityMemberDetails extends StatefulWidget {
  final int comityId;

  const ComityMemberDetails({Key key, this.comityId}) : super(key: key);

  @override
  State<ComityMemberDetails> createState() => _ComityMemberDetailsState();
}

class _ComityMemberDetailsState extends State<ComityMemberDetails> {
  List<ComityMemberDetailsModel> comityMembers = <ComityMemberDetailsModel>[];
  bool _isLoading = true;

  Future _getComityMemberDetails() async {
    final response = await http.get(Uri.parse(
        'https://econtact.votersmanagement.com/api/get-all-contacts/${widget.comityId}'));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            comityMembers.add(ComityMemberDetailsModel.fromJson(v));
          });
        }
        setState(() {
          _isLoading = false;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Connection Required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getComityMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comity Member Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _isLoading == false
              ? comityMembers.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: size.height / 2.50),
                      child: Text(
                        'No Member Added',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: comityMembers.length,
                          itemBuilder: (context, index) {
                            var items = comityMembers[index];
                            return Column(
                              children: [
                                Card(
                                  shadowColor: Colors.black,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  child: ListTile(
                                    title: Text(items.name),
                                    trailing: Wrap(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              if (await canLaunch(
                                                  'tel:${items.mobile}')) {
                                                await launch(
                                                    'tel:${items.mobile}');
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.phone,
                                              color: Colors.blue,
                                            )),
                                        IconButton(
                                          onPressed: () async {
                                            if (await canLaunch(
                                                "https://wa.me/${items.mobile}")) {
                                              await launch(
                                                  "https://wa.me/+91${items.mobile}");
                                            }
                                          },
                                          icon:
                                              const Icon(FontAwesome.whatsapp),
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    )
              :  CircularIndicator(height:0.75,),
          SignInButton(
            text: 'Add Member',
            width: 0.95.sw,
            callback: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>  AddComityMemberDetail(comityMemberId: widget.comityId,)));
            },
          )
        ],
      ),
    );
  }
}
