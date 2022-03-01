import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/constant/palette.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    'Send Message'
  ];
  final List<IconData> homeScreenIcons = [
    FontAwesome.user,
    FontAwesome. group,
    FontAwesome.search_plus,
    FontAwesome.address_book                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ,
    FontAwesome.home,
    FontAwesome.home,
    FontAwesome.home,
    FontAwesome.search_plus,
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
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 1.w,
              childAspectRatio: (2 / 1.2)),
          itemBuilder: (context, index) {
            var item = name[index];
            var icons = homeScreenIcons[index];
            return InkWell(
                splashColor: Colors.red.shade50,
                onTap: () {},
                child: Card(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(icons),
                    Text(item),
                  ],
                )));
          }),
    );
  }
}
