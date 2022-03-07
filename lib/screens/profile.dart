import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/constant/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ImagePicker _picker = ImagePicker();
  File imageFile;

  // File _image;
  _getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0.h),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: _getImage,
                        child: CircleAvatar(
                          radius: 48.r,
                          backgroundImage: imageFile == null
                              ? const AssetImage('assests/images/dp.png')
                              : FileImage(imageFile),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                          top: 50.h,
                          left: 58.w,
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
                      _listTile(' Name : Abhishek Patel', () {}),
                      _listTile('Mobile No: 7600175674', () {}),
                      _listTile(
                          'Email Id : patelabhishek102001@gmail.com', () {})
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
                      _listTile('Name : Abhishek Patel', () {}),
                      _listTile('Mobile No: 7600175674', () {}),
                      _listTile(
                          'Email Id : patelabhishek102001@gmail.com', () {})
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
                      _listTile('Name : Abhishek Patel', () {}),
                      _listTile('Mobile No: 7600175674', () {}),
                      _listTile(
                          'Email Id : patelabhishek102001@gmail.com', () {})
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
