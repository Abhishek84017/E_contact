import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key key}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  DateTime _selectedDate = DateTime.now();

  Future _selectdata(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirth.text = "$picked";
        _dateOfJoining.text = "$picked";
      });
    }
  }

  Future _addmembers() async {
    var data = <String, dynamic>{
      "code": _codeNo.text,
      "name": _fullName.text,
      "gotra": _gotra.text,
      "gender": genderValue,
      "age": _age.text,
      "blood_group": _bloodGroup.text,
      "date_of_birth": _dateOfBirth.text,
      "mobile": _mobile.text,
      "email": _email.text,
      "address": _address.text,
      "firm_name": _firmName.text,
      "office_address": _officeAddress.text,
      "occupation": _occupation.text,
      "occupation_detail": _occupationDetail.text,
      "office_contact": _officeContact.text,
      "image": null,
      "native_place": _nativePlace.text,
      "birth_place": _birthPlace.text,
      "date_of_join": _dateOfJoining.text,
      "social_group": _socialGroup.text,
      "status": 1,
      "barcode": "",
      "password": _password.text,
      "anniversary": _anniversaryDate.text,
      "father_name": _fatherName.text,
      "mother_name": _motherName.text,
      "office_email": _officeEmail.text,
      "reference": _reference.text,
      "special_achievement": "",
      "why_join": "545",
      "aadhar_no": _aadharNo.text,
      "token": "5745556",
      "marrital": _maritalStatus.text,
      "device_type": "ios",
      "proof": "5445454545"
    };

    final response = await http.post(
        Uri.https('https://econtact.votersmanagement.com/', 'api/add-member'),
        body: data);

    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: jsonData['message'], backgroundColor: Colors.red);
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Not Connected');
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went word');
    }
  }

  final TextEditingController _codeNo = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _gotra = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _firmName = TextEditingController();
  final TextEditingController _officeAddress = TextEditingController();
  final TextEditingController _occupation = TextEditingController();
  final TextEditingController _occupationDetail = TextEditingController();
  final TextEditingController _officeContact = TextEditingController();
  final TextEditingController _nativePlace = TextEditingController();
  final TextEditingController _birthPlace = TextEditingController();
  final TextEditingController _dateOfJoining = TextEditingController();
  final TextEditingController _socialGroup = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _anniversaryDate = TextEditingController();
  final TextEditingController _fatherName = TextEditingController();
  final TextEditingController _motherName = TextEditingController();
  final TextEditingController _officeEmail = TextEditingController();
  final TextEditingController _reference = TextEditingController();
  final TextEditingController _aadharNo = TextEditingController();
  final TextEditingController _maritalStatus = TextEditingController();

  String genderValue = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      'Add Members',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              InputField(
                text: 'Code No',
                controller: _codeNo,
                inputDecoration: const InputDecoration(labelText: 'Code No'),
              ),
              InputField(
                text: 'Full Name',
                controller: _fullName,
                inputDecoration: const InputDecoration(labelText: 'Full Name'),
              ),
              InputField(
                text: 'Gotra',
                controller: _gotra,
                inputDecoration: const InputDecoration(labelText: 'Gotra'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 7.h),
                      child: const Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          Radio(
                              value: 'Male',
                              groupValue: genderValue,
                              onChanged: (val) {
                                genderValue = val;
                                setState(() {});
                              }),
                          const Text('Male'),
                          Radio(
                              value: 'Female',
                              groupValue: genderValue,
                              onChanged: (val) {
                                genderValue = val;
                                setState(() {});
                              }),
                          const Text('Female'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InputField(
                text: 'Age',
                controller: _age,
                inputDecoration: const InputDecoration(labelText: 'Age'),
              ),
              InputField(
                text: 'Blood Group',
                controller: _bloodGroup,
                inputDecoration:
                    const InputDecoration(labelText: 'Blood Group'),
              ),
              InputField(
                readonly: true,
                text: 'Date Of Birth',
                controller: _dateOfBirth,
                onTap: () {
                  _selectdata(context);
                },
                inputDecoration:
                    const InputDecoration(labelText: 'Date Of Birth'),
              ),
              InputField(
                text: 'Mobile',
                controller: _mobile,
                inputDecoration: const InputDecoration(labelText: 'Mobile'),
              ),
              InputField(
                text: 'Email',
                controller: _email,
                inputDecoration: const InputDecoration(labelText: 'Email'),
              ),
              InputField(
                text: 'Address',
                controller: _address,
                inputDecoration: const InputDecoration(labelText: 'Address'),
              ),
              InputField(
                text: 'Firm Name',
                controller: _firmName,
                inputDecoration: const InputDecoration(labelText: 'Firm Name'),
              ),
              InputField(
                text: 'Office Address',
                controller: _officeAddress,
                inputDecoration:
                    const InputDecoration(labelText: 'Office Address'),
              ),
              InputField(
                text: 'Occupation',
                controller: _occupation,
                inputDecoration: const InputDecoration(labelText: 'Code no'),
              ),
              InputField(
                text: 'Occupation Detail',
                controller: _occupationDetail,
                inputDecoration:
                    const InputDecoration(labelText: 'Occupation Detail'),
              ),
              InputField(
                text: 'Office Contact',
                controller: _officeContact,
                inputDecoration:
                    const InputDecoration(labelText: 'Office Contact'),
              ),
              InputField(
                text: 'Native Place',
                controller: _nativePlace,
                inputDecoration:
                    const InputDecoration(labelText: 'Native Place'),
              ),
              InputField(
                text: 'Birth Place',
                controller: _birthPlace,
                inputDecoration:
                    const InputDecoration(labelText: 'Birth Place'),
              ),
              InputField(
                onTap: (){
                  _selectedDate;
                },
                text: 'Date Of Joining',
                controller: _dateOfJoining,
                inputDecoration:
                    const InputDecoration(labelText: 'Date Of Joining'),
              ),
              InputField(
                text: 'Social Group',
                controller: _socialGroup,
                inputDecoration:
                    const InputDecoration(labelText: 'Social Group'),
              ),
              InputField(
                text: 'password',
                controller: _password,
                inputDecoration: const InputDecoration(labelText: 'password'),
              ),
              InputField(
                text: 'anniversary',
                controller: _anniversaryDate,
                inputDecoration:
                    const InputDecoration(labelText: 'anniversary'),
              ),
              InputField(
                text: 'Father Name',
                controller: _fatherName,
                inputDecoration:
                    const InputDecoration(labelText: 'Father Name'),
              ),
              InputField(
                text: 'Mother Name',
                controller: _motherName,
                inputDecoration:
                    const InputDecoration(labelText: 'Mother Name'),
              ),
              InputField(
                text: 'Office Email',
                controller: _officeEmail,
                inputDecoration:
                    const InputDecoration(labelText: 'Office Email'),
              ),
              InputField(
                text: 'Reference',
                controller: _reference,
                inputDecoration: const InputDecoration(labelText: 'Reference'),
              ),
              InputField(
                text: 'Aadhar No',
                controller: _aadharNo,
                inputDecoration: const InputDecoration(labelText: 'Aadhar No'),
              ),
              InputField(
                text: 'Marital Status',
                controller: _maritalStatus,
                inputDecoration:
                    const InputDecoration(labelText: 'Marital Status'),
              ),
              SignInButton(
                text: 'Add Member',
                callback: _addmembers,
                width: 0.50.sw,
              )
            ],
          ),
        ),
      ),
    );
  }
}
