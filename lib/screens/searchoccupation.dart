import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:http/http.dart' as http;
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class OccupationModel {
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

  OccupationModel(
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

  OccupationModel.fromJson(Map<String, dynamic> json) {
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

class SearchOccupation extends StatefulWidget {
  const SearchOccupation({Key key}) : super(key: key);

  @override
  State<SearchOccupation> createState() => _SearchOccupationState();
}

class _SearchOccupationState extends State<SearchOccupation> {
  final TextEditingController _occupationInput = TextEditingController();
  List<OccupationModel> occupationsDetail = <OccupationModel>[];
  List<OccupationModel> searchOccupation = <OccupationModel>[];
  bool _isloading = true;

  void _occupationSearch(String newValue) {
    searchOccupation = occupationsDetail
        .where((element) =>
            element.occupation.toLowerCase().contains(newValue.toLowerCase()))
        .toList();
    setState(() {});
  }

  void _getOccupation() async {
    final response = await http.get(
        Uri.parse('https://econtact.votersmanagement.com/api/get-all-member'));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            occupationsDetail.add(OccupationModel.fromJson(v));
          });
        }
        setState(() {
          _isloading = false;
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
    _getOccupation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search By Occupation'),
        ),
        body: Column(
          children: [
            InputField(
              controller: _occupationInput,
              onChanged: _occupationSearch,
              inputDecoration:
                  const InputDecoration(hintText: 'Search By Occupation'),
            ),
            _isloading == true
                ? Padding(
                    padding: EdgeInsets.only(top: size.height / 3),
                    child: const Center(child: CircularIndicator()),
                  )
                : occupationsDetail.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: size.height / 3),
                        child: Text(
                          'No Data Found',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      )
                    : Expanded(
                        child: searchOccupation.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var items = searchOccupation[index];
                                  return Card(
                                    shadowColor: Colors.black,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      /*leading: CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(
                                  'https://econtact.votersmanagement.com/${items.image}'),
                              backgroundColor: Colors.transparent,
                            ),*/
                                      title: Text(items.name),
                                      subtitle: Text(items.occupation),
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
                                            icon: const Icon(
                                                FontAwesome.whatsapp),
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: searchOccupation.length,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var items1 = occupationsDetail[index];
                                  return Card(
                                    shadowColor: Colors.black,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      /*leading: CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(
                                  'https://econtact.votersmanagement.com/${items.image}'),
                              backgroundColor: Colors.transparent,
                            ),*/
                                      title: Text(items1.name),
                                      subtitle: Text(items1.occupation),
                                      trailing: Wrap(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                if (await canLaunch(
                                                    'tel:${items1.mobile}')) {
                                                  await launch(
                                                      'tel:${items1.mobile}');
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.phone,
                                                color: Colors.blue,
                                              )),
                                          IconButton(
                                            onPressed: () async {
                                              if (await canLaunch(
                                                  "https://wa.me/${items1.mobile}")) {
                                                await launch(
                                                    "https://wa.me/+91${items1.mobile}");
                                              }
                                            },
                                            icon: const Icon(
                                                FontAwesome.whatsapp),
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: occupationsDetail.length,
                              ),
                      )
          ],
        ),
      ),
    );
  }
}
