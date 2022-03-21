import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddComity extends StatefulWidget {
  const AddComity({Key key}) : super(key: key);

  @override
  State<AddComity> createState() => _AddComityState();
}

class _AddComityState extends State<AddComity> {
  final ImagePicker _picker = ImagePicker();
  File imageFile;
  bool _isLoading = true;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _image = TextEditingController();



  Future _getImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future _addComity() async {
    var data = <String, String>{
      "title": _title.text,
    };
    final request = http.MultipartRequest('POST', Uri.https('econtact.votersmanagement.com', 'api/add-committee'));
    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath("logo", imageFile.path));
    final streamResponse  = await request.send();
    try {
      if (streamResponse.statusCode == 200) {
        final jsonData = jsonDecode(await streamResponse.stream.bytesToString());
        Fluttertoast.showToast(msg: jsonData['message']);
        _title.clear();
        imageFile.path == null;
        setState(() {
          _isLoading = true;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'Internet Not Connected');
    } catch (_) {
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comity'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            text: 'title',
            controller: _title,
            inputDecoration: const InputDecoration(hintText: 'Title'),
          ),
          InputField(
            readonly: true,
            maxLines: 2,
            onTap: _getImage,
            text: 'Logo',
            controller: _image,
            inputDecoration: InputDecoration(
                hintText: imageFile == null
                    ? 'Upload Image'
                    : imageFile.path.split("/").last),
          ),
         _isLoading ? SignInButton(
            text: 'Add Comity',
            width: 0.75.sw,
            callback: (){
              if(_title.text.isEmpty)
                {
                  Fluttertoast.showToast(msg: 'Titel Required');
                  return;
                }
              if(imageFile == null)
                {
                  Fluttertoast.showToast(msg: 'Logo Required');
                  return;
                }
              setState(() {
                _isLoading = false;
              });
              _addComity();
            },
          ) : const CircularIndicator()
        ],
      ),
    );
  }
}
