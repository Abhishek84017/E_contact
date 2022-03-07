import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key key}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
    final TextEditingController _codeNo  = TextEditingController();
    final TextEditingController _fullName  = TextEditingController();
    final TextEditingController _gotra  = TextEditingController();
    final TextEditingController _gender  = TextEditingController();
    final TextEditingController _age  = TextEditingController();
    final TextEditingController _bloodGroup  = TextEditingController();
    final TextEditingController _dateOfBirth  = TextEditingController();
    final TextEditingController _mobile  = TextEditingController();
    final TextEditingController _email  = TextEditingController();
    final TextEditingController _address  = TextEditingController();
    final TextEditingController _firmName  = TextEditingController();
    final TextEditingController _officeAddress  = TextEditingController();
    final TextEditingController _occupation  = TextEditingController();
    final TextEditingController _occupationDetail  = TextEditingController();
    final TextEditingController _officeContact  = TextEditingController();
    final TextEditingController _nativePlace  = TextEditingController();
    final TextEditingController _birthPlace  = TextEditingController();
    final TextEditingController _dateOfJoining  = TextEditingController();
    final TextEditingController _socialGroup  = TextEditingController();
    final TextEditingController _password  = TextEditingController();
    final TextEditingController _anniversaryDate  = TextEditingController();
    final TextEditingController _fatherName  = TextEditingController();
    final TextEditingController _motherName  = TextEditingController();
    final TextEditingController _officeEmail  = TextEditingController();
    final TextEditingController _reference  = TextEditingController();
    final TextEditingController _aadharNo  = TextEditingController();
    final TextEditingController _maritalStatus  = TextEditingController();

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
                      style: TextStyle(color: Colors.black, fontSize: 24.sp,fontWeight: FontWeight.bold),
                    ),
                  )
              ),
              InputField(text: 'Code No',controller: _codeNo,inputDecoration: const InputDecoration(labelText: 'Code No'),),
              InputField(text:'Full Name',controller: _fullName,inputDecoration: const InputDecoration(labelText: 'Full Name'),),
              InputField(text:'Gotra',controller: _gotra,inputDecoration: const InputDecoration(labelText: 'Gotra'),),
              InputField(text:'Gender',controller: _gender,inputDecoration: const InputDecoration(labelText: 'Gender'),),
              InputField(text:'Age',controller: _age,inputDecoration: const InputDecoration(labelText: 'Age'),),
              InputField(text:'Blood Group',controller: _bloodGroup,inputDecoration: const InputDecoration(labelText: 'Blood Group'),),
              InputField(text:'Date Of Birth',controller: _dateOfBirth,inputDecoration: const InputDecoration(labelText: 'Date Of Birth'),),
              InputField(text:'Mobile',controller: _mobile,inputDecoration: const InputDecoration(labelText: 'Mobile'),),
              InputField(text:'Email',controller: _email,inputDecoration: const InputDecoration(labelText: 'Email'),),
              InputField(text:'Address',controller: _address,inputDecoration: const InputDecoration(labelText: 'Address'),),
              InputField(text:'Firm Name',controller: _firmName,inputDecoration: const InputDecoration(labelText: 'Firm Name'),),
              InputField(text:'Office Address',controller: _officeAddress,inputDecoration: const InputDecoration(labelText: 'Office Address'),),
              InputField(text:'Occupation',controller: _occupation,inputDecoration: const InputDecoration(labelText: 'Code no'),),
              InputField(text:'Occupation Detail',controller: _occupationDetail,inputDecoration: const InputDecoration(labelText: 'Occupation Detail'),),
              InputField(text:'Office Contact',controller: _officeContact,inputDecoration: const InputDecoration(labelText: 'Office Contact'),),
              InputField(text:'Native Place',controller: _nativePlace,inputDecoration: const InputDecoration(labelText: 'Native Place'),),
              InputField(text:'Birth Place',controller: _birthPlace,inputDecoration: const InputDecoration(labelText: 'Birth Place'),),
              InputField(text:'Date Of Joining',controller: _dateOfJoining,inputDecoration: const InputDecoration(labelText: 'Date Of Joining'),),
              InputField(text:'Social Group',controller: _socialGroup,inputDecoration: const InputDecoration(labelText: 'Social Group'),),
              InputField(text:'password',controller: _password,inputDecoration: const InputDecoration(labelText: 'password'),),
              InputField(text:'anniversary',controller: _anniversaryDate,inputDecoration: const InputDecoration(labelText: 'anniversary'),),
              InputField(text:'Father Name',controller: _fatherName,inputDecoration: const InputDecoration(labelText: 'Father Name'),),
              InputField(text:'Mother Name',controller: _motherName,inputDecoration: const InputDecoration(labelText: 'Mother Name'),),
              InputField(text:'Office Email',controller: _officeEmail,inputDecoration: const InputDecoration(labelText: 'Office Email'),),
              InputField(text:'Reference',controller: _reference,inputDecoration: const InputDecoration(labelText: 'Reference'),),
              InputField(text:'Aadhar No',controller: _aadharNo,inputDecoration: const InputDecoration(labelText: 'Aadhar No'),),
              InputField(text:'Marital Status',controller: _maritalStatus,inputDecoration: const InputDecoration(labelText: 'Marital Status'),),

            ],
          ),
        ),
      ),
    );
  }
}
