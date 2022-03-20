import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_of_the_week/pages/widgets/singinbutton.dart';
import 'package:widget_of_the_week/screens/addcomitymembersdetails.dart';

class ComityMemberDetails extends StatefulWidget {
  const ComityMemberDetails({Key key}) : super(key: key);

  @override
  State<ComityMemberDetails> createState() => _ComityMemberDetailsState();
}

class _ComityMemberDetailsState extends State<ComityMemberDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comity Member Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text('$index'),
                        ),
                      )
                    ],
                  );
                }),
          ),
          SignInButton(
            text: 'Add Member',
            width: 0.95.sw,
            callback: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddComityMemberDetail()));
            },
          )
        ],
      ),
    );
  }
}
