import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_of_the_week/pages/widgets/text_field.dart';

class MemberDetails extends StatefulWidget {
  const MemberDetails({Key key}) : super(key: key);

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

final List<Map<dynamic, String>> _memberDetails = [
  {
    "image": "assests/images/mens.jpg",
    "name": "Abhishek patel",
    "mobileNo": "tel:7600175674",
  },
  {
    "image": "assests/images/mens.jpg",
    "name": "Deepak parapet",
    "mobileNo": "tel:7878868606",
  },
  {
    "image": "assests/images/mens.jpg",
    "name": "Vivekanand viswakarma",
    "mobileNo": "tel:7600175674",
  },
  {
    "image": "assests/images/mens.jpg",
    "name": "Pritam Sharma",
    "mobileNo": "tel:8128355470",
  },
  {
    "image": "assests/images/mens.jpg",
    "name": "Awadhesh patel",
    "mobileNo": "tel:8401755067",
  },
  {
    "image": "assests/images/mens.jpg",
    "name": "Abhishek patel",
    "mobileNo": "tel:7600175674",
  },

];

class _MemberDetailsState extends State<MemberDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const InputField(textInputAction: TextInputAction.done,inputDecoration: InputDecoration(
              hintText: 'Search Members by name'
            ),),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var item = _memberDetails[index];
                  //final Uri launchUri = Uri(scheme: 'tel',path: item['mobileNo']);
                  return Card(
                    shadowColor: Colors.red,
                    margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      leading: CircleAvatar(
                        radius: 24.0,
                        backgroundImage: AssetImage(item['image']),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(item["name"]),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () async {
                                if (await canLaunch(item["mobileNo"])) {
                                  await launch(item["mobileNo"].toString());
                                }
                              },
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.blue,
                              )),
                          IconButton(
                            onPressed: () async {
                              if (await canLaunch(
                                  "https://wa.me/${item['mobileNo']}")) {
                                await launch("https://wa.me/+91${item['mobileNo']}");
                              }
                            },
                            icon: const Icon(FontAwesome.whatsapp),
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _memberDetails.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
