import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class AddContact extends StatefulWidget {
  final String name;
  final String mobileNo;

  const AddContact({Key key, this.name, this.mobileNo}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameSave = TextEditingController();
  TextEditingController _mobileNoSave = TextEditingController();

  bool _isloading = false;

  Future _saveContactInPhone() async {
    try {
      PermissionStatus permission = await Permission.contacts.status;

      if (permission != PermissionStatus.granted) {
        await Permission.contacts.request();
        PermissionStatus permission = await Permission.contacts.status;

        if (permission == PermissionStatus.granted) {
          Contact newContact = Contact();
          newContact.givenName = _nameSave.text;
          newContact.phones = [
            Item(label: 'mobile', value: _mobileNoSave.text)
          ];
          await ContactsService.addContact(newContact);
          setState(() {
            _isloading = false;
            Fluttertoast.showToast(msg: 'Mobile No Added In Contact');
          });
        }
      } else {
        Contact newContact = Contact();
        newContact.givenName = _nameSave.text;
        newContact.phones = [Item(label: 'mobile', value: _mobileNoSave.text)];
        await ContactsService.addContact(newContact);
        setState(() {
          _isloading = false;
          Fluttertoast.showToast(msg: 'Mobile No Added In Contact');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameSave = TextEditingController(text: widget.name);
    _mobileNoSave = TextEditingController(text: widget.mobileNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add Contact',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          InputField(
            text: 'Name',
            controller: _nameSave,
          ),
          InputField(
            text: 'Mobile No',
            controller: _mobileNoSave,
          ),
          _isloading == true
              ?  CircularIndicator(height:0.75,)
              : SignInButton(
                  width: 0.95.sw,
                  text: 'Add Contact',
                  callback: () {
                    if (_nameSave.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Name Required');
                      return;
                    }
                    if (_mobileNoSave.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Name Required');
                      return;
                    }
                    if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$")
                        .hasMatch(_mobileNoSave.text)) {
                      Fluttertoast.showToast(
                          msg: 'please enter valid mobile no');
                      return;
                    }
                    setState(() {
                      _isloading = true;
                    });
                    _saveContactInPhone();
                  },
                )
        ],
      ),
    );
  }
}
