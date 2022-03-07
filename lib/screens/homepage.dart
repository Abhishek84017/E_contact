import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/constant/palette.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:widget_of_the_week/screens/addmembers.dart';
import 'package:widget_of_the_week/screens/member_details.dart';
import 'package:widget_of_the_week/screens/profile.dart';
import 'package:widget_of_the_week/screens/send_messages.dart';
import 'package:widget_of_the_week/screens/send_notification.dart';
import 'package:widget_of_the_week/screens/send_whatsapp_messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> name = [
    "My Profile",
    "Comity Details",
    "Member Details",
    'Search Occupation',
    'Add Member',
    "Send Notification",
    'Send Whatsapp',
    'Send Message',
    'Calender',
    'Media Corner',
  ];
  final List<IconData> homeScreenIcons = [
    FontAwesome.user,
    FontAwesome.group,
    FontAwesome.address_book,
    FontAwesome.search,
    FontAwesome.home,
    FontAwesome.paper_plane,
    FontAwesome.whatsapp,
    Icons.message,
    FontAwesome.calendar,
    FontAwesome.camera
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.basicColor,
        title: const Text('Heading'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            splashColor: Colors.red,
          ),
        ],
      ),

      //body: const Center(child: Text('hello',style: TextStyle(fontSize: 100),)),
      body: GridView.builder(
          itemCount: name.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
              crossAxisSpacing: 1.w,
              mainAxisSpacing: 1.w,
              childAspectRatio: (2 / 1.3)),
          itemBuilder: (context, index) {
            var item = name[index];
            var icons = homeScreenIcons[index];
            return Card(
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.w),
                  onTap: () {
                    if (item == 'Add Member') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const AddMembers()));
                    }
                    if (item == 'My Profile') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyProfile()));
                    }
                    if (item == 'My Profile') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyProfile()));
                    }
                    if (item == 'Member Details') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MemberDetails()));
                    }
                    if (item == 'Send Notification') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SendNotification()));
                    }
                    if (item == 'Send Whatsapp') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const SendWhatsappMessage()));
                    }
                    if (item == 'Send Message') {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                              const SendMessages()));
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(icons),
                      Text(item),
                    ],
                  ),
                ));
          }),
    );
  }
}
