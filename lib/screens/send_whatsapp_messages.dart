import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



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

class MemberDetailsModel {
  int id;
  String code;
  String name;
  String gotra;
  String gender;
  int age;
  String bloodGroup;
  String dateOfBirth;
  String mobile;
  String email;
  String address;
  String firmName;
  String officeAddress;
  String occupation;
  String occupationDetail;
  String officeContact;
  String image;
  String nativePlace;
  String birthPlace;
  String dateOfJoin;
  String socialGroup;
  int status;
  String barcode;
  String password;
  String anniversary;
  String fatherName;
  String motherName;
  String officeEmail;
  String reference;
  String specialAchievement;
  String whyJoin;
  String aadharNo;
  String token;
  String marrital;
  String deviceType;
  String proof;

  MemberDetailsModel(
      {this.id,
      this.code,
      this.name,
      this.gotra,
      this.gender,
      this.age,
      this.bloodGroup,
      this.dateOfBirth,
      this.mobile,
      this.email,
      this.address,
      this.firmName,
      this.officeAddress,
      this.occupation,
      this.occupationDetail,
      this.officeContact,
      this.image,
      this.nativePlace,
      this.birthPlace,
      this.dateOfJoin,
      this.socialGroup,
      this.status,
      this.barcode,
      this.password,
      this.anniversary,
      this.fatherName,
      this.motherName,
      this.officeEmail,
      this.reference,
      this.specialAchievement,
      this.whyJoin,
      this.aadharNo,
      this.token,
      this.marrital,
      this.deviceType,
      this.proof});

  MemberDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    gotra = json['gotra'];
    gender = json['gender'];
    age = json['age'];
    bloodGroup = json['blood_group'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    firmName = json['firm_name'];
    officeAddress = json['office_address'];
    occupation = json['occupation'];
    occupationDetail = json['occupation_detail'];
    officeContact = json['office_contact'];
    image = json['image'];
    nativePlace = json['native_place'];
    birthPlace = json['birth_place'];
    dateOfJoin = json['date_of_join'];
    socialGroup = json['social_group'];
    status = json['status'];
    barcode = json['barcode'];
    password = json['password'];
    anniversary = json['anniversary'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    officeEmail = json['office_email'];
    reference = json['reference'];
    specialAchievement = json['special_achievement'];
    whyJoin = json['why_join'];
    aadharNo = json['aadhar_no'];
    token = json['token'];
    marrital = json['marrital'];
    deviceType = json['device_type'];
    proof = json['proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['gotra'] = gotra;
    data['gender'] = gender;
    data['age'] = age;
    data['blood_group'] = bloodGroup;
    data['date_of_birth'] = dateOfBirth;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['firm_name'] = firmName;
    data['office_address'] = officeAddress;
    data['occupation'] = occupation;
    data['occupation_detail'] = occupationDetail;
    data['office_contact'] = officeContact;
    data['image'] = image;
    data['native_place'] = nativePlace;
    data['birth_place'] = birthPlace;
    data['date_of_join'] = dateOfJoin;
    data['social_group'] = socialGroup;
    data['status'] = status;
    data['barcode'] = barcode;
    data['password'] = password;
    data['anniversary'] = anniversary;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['office_email'] = officeEmail;
    data['reference'] = reference;
    data['special_achievement'] = specialAchievement;
    data['why_join'] = whyJoin;
    data['aadhar_no'] = aadharNo;
    data['token'] = token;
    data['marrital'] = marrital;
    data['device_type'] = deviceType;
    data['proof'] = proof;
    return data;
  }
}

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

class SendWhatsappMessage extends StatefulWidget {
  const SendWhatsappMessage({Key key}) : super(key: key);

  @override
  State<SendWhatsappMessage> createState() => _SendWhatsappMessageState();
}

class _SendWhatsappMessageState extends State<SendWhatsappMessage> {
  bool _isMemberSend = true;
  final TextEditingController _textmessage = TextEditingController();
  List<MemberDetailsModel> memberDetail = <MemberDetailsModel>[];
  List<String> mobileNo = <String>[];
  List<String> mobileWith = <String>[];


  Future _sendWhatsAppMessage() async {
    print('hello');
    memberDetail.clear();
    mobileWith.clear();
    final response = await http.get(Uri.parse('https://econtact.votersmanagement.com/api/get-all-member'));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            memberDetail.add(MemberDetailsModel.fromJson(v));
          });
        }
        mobileNo = memberDetail.map((e) => e.mobile).toList();

        for( var i =0 ;i < mobileNo.length ; i++)
          {
            mobileWith.add('91${mobileNo[i]}');
          }
          print(mobileWith);
        if (mobileNo.isNotEmpty) {
          final request = await http.get(Uri.parse(
              'https://api.wapp.jiyaninfosoft.com/v1/sendMessage?to=$mobileWith}&messageType=text&message=hello_testing_message&caption=&instanceId=bb2c5bd5-dcca-4b16-b1a746f5f70a8467&channel=whatsapp&authToken=36c0cfde-ee94-4961-a34b-c913dab54d7d'));
          print(request.request);
          try {
            if (request.statusCode == 200) {
              final jsonData = jsonDecode(request.body);
              if (jsonData['statusCode'] == 862) {
                Fluttertoast.showToast(msg: jsonData['message']);
              } else if (jsonData['statusCode'] == 1) {
                Fluttertoast.showToast(msg: jsonData['successMessage']);
              }
              _textmessage.clear();
              setState(() {
                _isMemberSend = true;
              });
            }
          } catch (_) {
            Fluttertoast.showToast(msg: 'Something Went Wrong');
          }
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Connection Required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    _isMemberSend = true;
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
                _isMemberSend == true
                    ? SignInButton(
                        text: 'Send',
                        callback: () {
                          if (_textmessage.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter Message');
                            return;
                          }
                          setState(() {
                            _isMemberSend = false;
                          });
                          _sendWhatsAppMessage();
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: const CircularIndicator(),
                      ),
                SignInButton(
                  text: 'Send To Group',
                  callback: () async {
                    if (_textmessage.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter Message');
                      return;
                    }
                    return await showDialog(
                        context: context,
                        builder: (_) {
                          return ShowData(
                            textMessage: _textmessage.text,
                          );
                        });
                  },
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

class ShowData extends StatefulWidget {
  final String textMessage;

  const ShowData({Key key, this.textMessage}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<ComityDetailsModel> comityDetail = <ComityDetailsModel>[];
  List<String> comityNames = <String>[];
  List<int> a = <int>[];
  bool _isComityLoading = true;
  Map<int, bool> answer = {};
  List<ComityMemberDetailsModel> comityMembers = <ComityMemberDetailsModel>[];
  int checkedComityNumber;
  List<String> comityMembersMobileNo = <String>[];
  bool _sendWhatsappMessageMembers = true;

  Future _getComity() async {
    a.clear();
    comityDetail.clear();
    final response = await http.get(Uri.parse(
        'https://econtact.votersmanagement.com/api/get-all-committee'));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            comityDetail.add(ComityDetailsModel.fromJson(v));
          });
          comityNames = comityDetail.map((e) => e.title).toList();
          setState(() {
            _isComityLoading = false;
          });
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Required');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future _sendMessageComityMembers() async {
    for (var i = 0; i < a.length; i++) {
      int c = a[i];
      print(c + 1);
      final response = await http.get(Uri.parse(
          'https://econtact.votersmanagement.com/api/get-all-contacts/${c + 1}'));
      try {
        if (response.statusCode == 200) {
          comityMembers.clear();
          final jsonData = jsonDecode(response.body);
          if (jsonData['data'] != null) {
            jsonData['data'].forEach((v) {
              comityMembers.add(ComityMemberDetailsModel.fromJson(v));
            });
          }
          comityMembersMobileNo = comityMembers.map((e) => e.mobile).toList();
          print(comityMembers.length);
          print(comityMembersMobileNo);
          for (var j = 0; j < comityMembersMobileNo.length; j++) {
            final request = await http.get(Uri.parse(
                'https://api.wapp.jiyaninfosoft.com/v1/sendMessage?to=91${comityMembersMobileNo[j]}&messageType=text&message=${widget.textMessage}&caption=&instanceId=bb2c5bd5-dcca-4b16-b1a746f5f70a8467&channel=whatsapp&authToken=36c0cfde-ee94-4961-a34b-c913dab54d7d'));
            if (j - comityMembersMobileNo.length == -1) {
              try {
                if (request.statusCode == 200) {
                  final jsonData = jsonDecode(request.body);
                  if (jsonData['statusCode'] == 862) {
                    Fluttertoast.showToast(msg: jsonData['message']);
                  } else if (jsonData['statusCode'] == 1 &&
                      i - a.length == -1) {
                    setState(() {
                      _sendWhatsappMessageMembers = true;
                      Navigator.pop(context, true);
                    });
                    Fluttertoast.showToast(msg: jsonData['successMessage']);
                  }
                }
              } catch (_) {
                Fluttertoast.showToast(msg: 'Something Went Wrong');
              }
            }
          }
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: 'Internet Connection Required');
      } catch (_) {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getComity();
  }

  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;
    return _isComityLoading
        ? const CircularIndicator()
        : AlertDialog(
            content: Container(
                height: 500,
                width: 300,
                child: StatefulBuilder(builder: (context, setState) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: comityNames.length,
                    itemBuilder: (context, index) {
                      var items = comityNames[index];
                      return StatefulBuilder(builder: (context, setState) {
                        return CheckboxListTile(
                            title: Text(items.toString()),
                            value: answer[index] ?? false,
                            onChanged: (bool newValue) {
                              setState(() {
                                answer[index] = newValue;
                                if (answer[index] == true) {
                                  a.add(index);
                                }
                                if (answer[index] == false) {
                                  a.remove(index);
                                }
                              });
                            });
                      });
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.grey,
                    ),
                  );
                })),
            actions: [
              _sendWhatsappMessageMembers
                  ? TextButton(
                      onPressed: () {
                        _sendMessageComityMembers();
                        setState(() {
                          _sendWhatsappMessageMembers = false;
                        });
                      },
                      child: const Text('Send'))
                  : const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
            ],
          );
  }
}
