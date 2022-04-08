import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
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
  final ImagePicker _picker = ImagePicker();
  File imageFile;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _image = TextEditingController();
  bool _isLoading = true;
  List<ComityDetailsModel> comityDetail = <ComityDetailsModel>[];

  Future _getComityDetails() async {
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

  Future _getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        print(imageFile.path.split('/').last);
      });
    }
  }

  Future _addComityDetails() async {
    var data = <String, String>{
      "title": _title.text,
    };
    final request = http.MultipartRequest('POST',
        Uri.https('econtact.votersmanagement.com', 'api/add-committee'));
    request.fields.addAll(data);
    request.files
        .add(await http.MultipartFile.fromPath("logo", imageFile.path));
    final streamResponse = await request.send();
    try {
      if (streamResponse.statusCode == 200) {
        final jsonData =
            jsonDecode(await streamResponse.stream.bytesToString());
        Fluttertoast.showToast(msg: jsonData['message']);
        _title.clear();
        imageFile.path == null;
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Not Connected');
    } catch (_) {
      Fluttertoast.showToast(msg: 'something went wrong');
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
          ? const CircularIndicator(height:0.75,)
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: comityDetail.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 3
                              : 2,
                          crossAxisSpacing: 1.w,
                          mainAxisSpacing: 1.w,
                          childAspectRatio: (2 / 1.3)),
                      itemBuilder: (context, index) {
                        var item = comityDetail[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ComityMemberDetails(
                                          comityId: item.id,
                                        ))),
                            child: Card(
                              shadowColor: Colors.white,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                  callback: () async {
                    return await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              InputField(
                                readonly: true,
                                maxLines: 2,
                                onTap: () {
                                  _getImage();
                                },
                                text: 'Logo',
                                controller: _image,
                                inputDecoration: InputDecoration(
                                    hintText: imageFile == null
                                        ? 'Upload Image'
                                        : imageFile.path.split("/").last),
                              ),
                              InputField(
                                text: 'title',
                                controller: _title,
                                inputDecoration:
                                    const InputDecoration(hintText: 'Title'),
                              ),
                              SignInButton(
                                text: 'Add Comity Details',
                                width: 0.75.sw,
                                callback: () {
                                  if (_title.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Titel Required');
                                    return;
                                  }
                                  if (imageFile == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Logo Required');
                                    return;
                                  }
                                  _addComityDetails();
                                },
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
    );
  }
}
