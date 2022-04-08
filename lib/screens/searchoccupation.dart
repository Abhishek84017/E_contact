import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_of_the_week/models/searchoccupationmodel.dart';
import 'package:widget_of_the_week/pages/widgets/circular.dart';
import 'package:widget_of_the_week/pages/widgets/dropdownbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:widget_of_the_week/services/urls.dart';

import 'add_contact.dart';

class SearchOccupation extends StatefulWidget {
  const SearchOccupation({Key key}) : super(key: key);

  @override
  State<SearchOccupation> createState() => _SearchOccupationState();
}

class _SearchOccupationState extends State<SearchOccupation> {
  var client = http.Client();

  String defaultOccupation;
  List<String> data = <String>[];

  bool _isLoading = true;

  List<SearchOccupationModel> searchMemberDetail = <SearchOccupationModel>[];
  List<SearchOccupationModel> selectedOccupation = <SearchOccupationModel>[];

  Future getMember() async {
    searchMemberDetail.clear();
    Uri uri = (Uri.http(Urls.base_Url, Urls.get_Members));
    final response = await client.get(uri);
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            searchMemberDetail.add(SearchOccupationModel.fromJson(v));
          });
        }
        data = searchMemberDetail.map((e) => e.occupation).toSet().toList();

        setState(() {
          _isLoading = false;
          if (searchMemberDetail.isNotEmpty) {
            defaultOccupation = searchMemberDetail.first.occupation;
          }
        });
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search By Occupation'),
      ),
      body: Column(
        children: [
         _isLoading ? const CircularIndicator(height: 0.75,) : DropDownButtonWidget(
           hinttext: 'Select Occupation',
           value: defaultOccupation,
           items: data.map((String value) {
             return DropdownMenuItem(
               child: Text(value),
               value: value,
             );
           }).toList(),
           callback: (newValue) {
             setState(() {
               defaultOccupation = newValue;
               selectedOccupation = searchMemberDetail
                   .where((element) => element.occupation.contains(newValue))
                   .toList();
             });
           },
         ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: selectedOccupation.length,
              itemBuilder: (context, index) {
                var item = selectedOccupation[index];
                return Card(
                  shadowColor: Colors.black,
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                        "http://econtact.votersmanagement.com/${item.image}",
                        imageBuilder:
                            (context, imageProvider) =>
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(50)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.occupation),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (await canLaunch(
                                  'tel:${item.mobile}')) {
                                await launch(
                                    'tel:${item.mobile}');
                              }
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.blue,
                            )),
                        IconButton(
                          onPressed: () async {
                            if (await canLaunch(
                                "https://wa.me/${item.mobile}")) {
                              await launch(
                                  "https://wa.me/+91${item.mobile}");
                            }
                          },
                          icon: const Icon(
                              FontAwesome.whatsapp),
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: ()  {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => AddContact(name: item.name,mobileNo:item.mobile,)));
                          },
                          icon: const Icon(
                              FontAwesome.plus),
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
