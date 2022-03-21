import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/constant/palette.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:widget_of_the_week/screens/comitydetails.dart';
import 'package:widget_of_the_week/screens/addmembers.dart';
import 'package:widget_of_the_week/screens/member_details.dart';
import 'package:widget_of_the_week/screens/profile.dart';
import 'package:widget_of_the_week/screens/searchoccupation.dart';
import 'package:widget_of_the_week/screens/send_messages.dart';
import 'package:widget_of_the_week/screens/send_notification.dart';
import 'package:widget_of_the_week/screens/send_whatsapp_messages.dart';
import 'package:widget_of_the_week/constant/globle.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key, this.mobile}) : super(key: key);
  final String mobile;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool finalAdminData;
  String homePageMobileNo;

  final List<String> name = [
    "Comity Details",
    "Member Details",
    'Search Occupation',
    'Add Member',
    "Send Notification",
    'Send Whatsapp',
    'Send Message',
  ];

  final List<String> name2 = [
    "My Profile",
    "Comity Details",
    "Member Details",
    'Search Occupation',
  ];

  final List<IconData> homeScreenIcons = [
    FontAwesome.group,
    FontAwesome.address_book,
    FontAwesome.search,
    FontAwesome.home,
    FontAwesome.paper_plane,
    FontAwesome.whatsapp,
    Icons.message,
  ];

  final List<IconData> homeScreenIcons2 = [
    FontAwesome.user,
    FontAwesome.group,
    FontAwesome.address_book,
    FontAwesome.search,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAdmin();
  }

  Future checkAdmin() async {
    homePageMobileNo = widget.mobile;
    bool adminValue = kSharedPreferences.getBool('Admin');
    setState(() {
      finalAdminData = adminValue;
    });
  }

  Future<bool> _onbackpress() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do you want to exit the application'),
              actions: [
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    kSharedPreferences.clear();
                    name.clear();
                    Navigator.pop(context, true);
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpress,
      child: Scaffold(
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
              onPressed: () {
                print('hello');
                print(widget.mobile);
              },
              splashColor: Colors.red,
            ),
          ],
        ),

        //body: const Center(child: Text('hello',style: TextStyle(fontSize: 100),)),
        body: GridView.builder(
            itemCount: finalAdminData == true ? name.length : name2.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3
                        : 2,
                crossAxisSpacing: 1.w,
                mainAxisSpacing: 1.w,
                childAspectRatio: (2 / 1.3)),
            itemBuilder: (context, index) {
              var item = finalAdminData == true ? name[index] : name2[index];
              var icons = finalAdminData == true
                  ? homeScreenIcons[index]
                  : homeScreenIcons2[index];
              return Card(
                  shadowColor: Colors.white,
                  elevation: 10,
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
                      if (item == 'Comity Details') {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const ComityDetails()));
                      }
                      if (item == 'My Profile') {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => MyProfile(
                                      mobileCheck:homePageMobileNo,
                                    )));
                      }

                      if (item == 'Member Details') {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const MemberDetails()));
                      }
                      if (item == 'Search Occupation') {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const SearchOccupation()));
                      }
                      if (item == 'Send Notification') {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const SendNotification()));
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
                                builder: (context) => const SendMessages()));
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
      ),
    );
  }
}
