import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/constant/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/screens/homepage.dart';

class ProfileModel {
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

  ProfileModel(
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

  ProfileModel.fromJson(Map<String, dynamic> json) {
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

class MyProfile extends StatefulWidget {
  final String mobileCheck;
  const MyProfile({Key key, this.mobileCheck}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ImagePicker _picker = ImagePicker();
  List<ProfileModel> memberDetail = <ProfileModel>[];
  List<ProfileModel> profileDetail = <ProfileModel>[];
  List<String> data;
  File imageFile;
  bool _isLoading = true;
  bool _imageLoading = false;
  List<Map<String, dynamic>> _profileData;

  // File _image;
  Future _getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      if (imageFile.path.isNotEmpty) {
        return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Do you want Update Image'),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        _upLoadImage();
                        Navigator.pop(context, true);
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _imageLoading = true;
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context, false);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ));
      }
    }
  }

  Future _getMemberDetails() async {
    final response = await http.get(
        Uri.parse('https://econtact.votersmanagement.com/api/get-all-member'));

    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            memberDetail.add(ProfileModel.fromJson(v));
          });
        }
        profileDetail = memberDetail
            .where((element) => element.code.contains(widget.mobileCheck))
            .toList();

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

  Future _upLoadImage() async {
    var data = <String, String>{
      "id": profileDetail[0].id.toString(),
    };
    final request = await http.MultipartRequest('POST',
        Uri.http('econtact.votersmanagement.com', 'api/upload-member-image'));
    request.fields.addAll(data);
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Image Uploaded');
        Navigator.pop(context, true);
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0.w),
            child: _isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: size.height / 2.50),
                    child: const CircularIndicator(),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0.h),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: _getImage,
                              child: _imageLoading == false
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://econtact.votersmanagement.com/${profileDetail[0].image}",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )
                                  : const CircularIndicator(),
                            ),
                            Positioned(
                                top: 50.h,
                                left: 55.w,
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed: () => _getImage(),
                                      icon: const Icon(Icons.edit),
                                      color: Colors.white,
                                      iconSize: 18.0.sp,
                                      alignment: Alignment.center,
                                    )))
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.0.w),
                            child: Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          )),
                      Card(
                        margin: EdgeInsets.only(bottom: 20.0.h),
                        child: Column(
                          children: [
                            _listTile(' Name:         ${profileDetail[0].name}',
                                () {}),
                            _listTile('Mobile No:  ${profileDetail[0].mobile}',
                                () {}),
                            _listTile(
                                'Email Id:       ${profileDetail[0].email}',
                                () {})
                          ],
                        ),
                        shadowColor: Palette.shadowColor,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.0.w),
                            child: Text(
                              'Office Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          )),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 20.0.h),
                        child: Column(
                          children: [
                            _listTile(
                                'Name:            ${profileDetail[0].firmName}',
                                () {}),
                            _listTile(
                                'Mobile No:    ${profileDetail[0].officeContact}',
                                () {}),
                            _listTile(
                                'Email Id:        ${profileDetail[0].officeEmail}',
                                () {})
                          ],
                        ),
                        shadowColor: Palette.shadowColor,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.0.w),
                            child: Text(
                              'Other Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          )),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 20.0.h),
                        child: Column(
                          children: [
                            _listTile(
                                'Occupation:    ${profileDetail[0].occupation}',
                                () {}),
                            _listTile(
                                'Date Of Birth: ${profileDetail[0].dateOfBirth}',
                                () {}),
                            _listTile(
                                'Birth Place:     ${profileDetail[0].birthPlace}',
                                () {})
                          ],
                        ),
                        shadowColor: Palette.shadowColor,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _listTile(
    String title,
    GestureTapCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
