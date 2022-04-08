import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/dropdownbutton.dart';
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
  final ImagePicker _picker = ImagePicker();
  File imageFile;
  bool _isloading = true;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedJoining = DateTime.now();

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
      });
    }
  }

  Future _dateJoining(BuildContext context) async {
    final DateTime joiningDate = await showDatePicker(
      context: context,
      initialDate: _selectedJoining,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (joiningDate != null) {
      _selectedJoining = joiningDate;
      _dateOfJoining.text = "$joiningDate";
    }
  }

  Future _getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future _addmembers() async {
    var data = <String, String>{
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
      "native_place": _nativePlace.text,
      "birth_place": _birthPlace.text,
      "date_of_join": _dateOfJoining.text,
      "social_group": _socialGroup.text,
      "status": "1",
      "barcode": "",
      "password": _password.text,
      "anniversary": "1997-05-28",
      "father_name": _fatherName.text,
      "mother_name": _motherName.text,
      "office_email": _officeEmail.text,
      "reference": _reference.text,
      "special_achievement": "445654",
      "why_join": "545",
      "aadhar_no": _aadharNo.text,
      "token": "5745556",
      "marrital": maritalValue,
      "device_type": "ios",
      "proof": _proof.text,
    };
    final request = http.MultipartRequest('POST', Uri.https('econtact.votersmanagement.com', '/api/add-member'));
    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath("image", imageFile.path));
    final streamResponse = await request.send();
    try {
      if (streamResponse.statusCode == 200) {
        final jsonData =
            jsonDecode(await streamResponse.stream.bytesToString());
        Fluttertoast.showToast(
            msg: jsonData['message'], backgroundColor: Colors.black);
        _codeNo.clear();
        _fullName.clear();
        _gotra.clear();
        genderValue = "";
        _age.clear();
        _bloodGroup.clear();
        _dateOfBirth.clear();
        _mobile.clear();
        _email.clear();
        _address.clear();
        _firmName.clear();
        _officeAddress.clear();
        _occupation.clear();
        _occupationDetail.clear();
        _officeContact.clear();
        _nativePlace.clear();
        _birthPlace.clear();
        _dateOfJoining.clear();
        _socialGroup.clear();
        _password.clear();
        _fatherName.clear();
        _motherName.clear();
        _officeEmail.clear();
        _reference.clear();
        _aadharNo.clear();
        _proof.clear();
        maritalValue == '';
        _image.clear();
        setState(() {
          _isloading = true;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Not Connected');
    } catch (_) {
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }

  final TextEditingController _codeNo = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _gotra = TextEditingController();
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
  final TextEditingController _fatherName = TextEditingController();
  final TextEditingController _motherName = TextEditingController();
  final TextEditingController _officeEmail = TextEditingController();
  final TextEditingController _reference = TextEditingController();
  final TextEditingController _aadharNo = TextEditingController();
  final TextEditingController _proof = TextEditingController();
  final TextEditingController _image = TextEditingController();

  String genderValue = '';
  String maritalValue = '';

  String dropdownvalue = "AEREN";
  String dropdownblood = "A+";

  var gotraData = [
    "AEREN",
    "BANSAL",
    "BHANDAL",
    "GOYAL",
    "MITTAL",
    "MAITREYA",
    "JINDAL",
    "KUCHHAL",
    "MENGAL",
    "BINDAL",
    "DHARAN",
    "GARG",
    "GOEN",
    "KANSAL",
    "MRIDKUL",
    "NAGAL",
    "SINGHAL",
    "TAYAL",
    "TINGAL"
  ];
  var Blood = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

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
                keyboardType: TextInputType.number,
                text: 'Code No',
                controller: _codeNo,
                inputDecoration: const InputDecoration(labelText: 'Code No'),
              ),
              InputField(
                text: 'Full Name',
                controller: _fullName,
                inputDecoration: const InputDecoration(labelText: 'Full Name'),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.h, top: 12.h),
                    child: const Text(
                      'Gotra',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )),
              DropDownButtonWidget(
                value: dropdownvalue,
                hinttext: 'Gotra',
                items: gotraData.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                callback: (newvalue) {
                  setState(() {
                    dropdownvalue = newvalue;
                    _gotra.text = newvalue;
                  });
                },
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
                keyboardType: TextInputType.number,
                text: 'Age',
                controller: _age,
                inputDecoration: const InputDecoration(labelText: 'Age'),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.h, top: 12.h),
                    child: const Text(
                      'Blood Group',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )),
              DropDownButtonWidget(
                value: dropdownblood,
                hinttext: 'Blood Group',
                items: Blood.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                callback: (newvalue) {
                  setState(() {
                    dropdownblood = newvalue;
                    _bloodGroup.text = newvalue;
                  });
                },
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
                keyboardType: TextInputType.number,
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
                inputDecoration: const InputDecoration(labelText: 'Occupation'),
              ),
              InputField(
                text: 'Occupation Detail',
                controller: _occupationDetail,
                inputDecoration:
                    const InputDecoration(labelText: 'Occupation Detail'),
              ),
              InputField(
                keyboardType: TextInputType.number,
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
                readonly: true,
                onTap: () {
                  _dateJoining(context);
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
                obscureText: true,
                maxLines: 1,
                text: 'password',
                controller: _password,
                inputDecoration: const InputDecoration(labelText: 'password'),
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
                keyboardType: TextInputType.number,
                text: 'Aadhar No',
                controller: _aadharNo,
                inputDecoration: const InputDecoration(labelText: 'Aadhar No'),
              ),
              InputField(
                text: 'Proof',
                controller: _proof,
                inputDecoration: const InputDecoration(labelText: 'Aadhar No'),
              ),
              InputField(
                readonly: true,
                maxLines: 2,
                onTap: _getImage,
                text: 'Upload Image',
                controller: _image,
                inputDecoration: InputDecoration(
                    hintText: imageFile == null
                        ? 'Upload Image'
                        : imageFile.path.split("/").last),
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
                        'Marital Status',
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
                              value: 'Y',
                              groupValue: maritalValue,
                              onChanged: (val) {
                                maritalValue = val;
                                setState(() {});
                              }),
                          const Text('Married'),
                          Radio(
                              value: 'N',
                              groupValue: maritalValue,
                              onChanged: (val) {
                                maritalValue = val;
                                setState(() {});
                              }),
                          const Text('UnMarried'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _isloading
                  ? SignInButton(
                      text: 'Add Member',
                      callback: () {
                        if (_codeNo.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'CodeNo is required');
                          return;
                        }
                        if (_fullName.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Name is required');
                          return;
                        }
                        if (_gotra.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Gotra is required');
                          return;
                        }
                        if (genderValue.isEmpty) {
                          Fluttertoast.showToast(msg: 'Gender is required');
                          return;
                        }
                        if (_age.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Age is required');
                          return;
                        }
                        var b = int.parse(_age.text);
                        if (b < 18) {
                          Fluttertoast.showToast(
                              msg: 'Age must be Greater than 18');
                          return;
                        }

                        if (_bloodGroup.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Blood Group is Required');
                          return;
                        }
                        if (_dateOfBirth.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Date of Birth is Required');
                          return;
                        }
                        if (_mobile.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Mobile No  is Required');
                          return;
                        }
                        if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$")
                            .hasMatch(_officeContact.text)) {
                          Fluttertoast.showToast(
                              msg: 'please enter valid officeContact');
                          return;
                        }
                        if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$")
                            .hasMatch(_mobile.text)) {
                          Fluttertoast.showToast(
                              msg: 'please enter valid mobile number');
                          return;
                        }
                        if (_email.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'E-mail is required');
                          return;
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_email.text)) {
                          Fluttertoast.showToast(
                              msg: 'please enter valid email');
                        }
                        if (_address.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Address is required');
                          return;
                        }
                        if (_firmName.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'FirmName is required');
                          return;
                        }
                        if (_officeAddress.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Office Address is required');
                          return;
                        }
                        if (_occupation.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Occupation_addmembers is required');
                          return;
                        }
                        if (_occupationDetail.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'OccupationDetail is required');
                          return;
                        }
                        if (_officeContact.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'OfficeContact is required');
                          return;
                        }
                        if (_nativePlace.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'NativePlace is required');
                          return;
                        }
                        if (_birthPlace.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Birthplace is required');
                          return;
                        }
                        if (_dateOfJoining.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Date of joining is required');
                          return;
                        }
                        if (_socialGroup.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Social group is required');
                          return;
                        }
                        if (_password.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Password is required');
                          return;
                        }
                        if (_fatherName.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Father Name is required');
                          return;
                        }
                        if (_motherName.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Mother Name is required');
                          return;
                        }
                        if (_officeEmail.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Office Email is required');
                          return;
                        }
                        if (_reference.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'References is required');
                          return;
                        }
                        if (_aadharNo.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Aadhar no is required');
                        }
                        if (maritalValue.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Marital Status  is required');
                          return;
                        }
                        if(imageFile.path.isEmpty)
                          {
                            Fluttertoast.showToast(msg: 'Image Required');
                            return;
                          }
                        setState(() {
                          _isloading = false;
                        });
                        _addmembers();
                      },
                      width: 0.50.sw,
                    )
                  : const CircularIndicator(height:0.75,),
            ],
          ),
        ),
      ),
    );
  }
}
