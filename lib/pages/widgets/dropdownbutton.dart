import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButtonWidget extends StatelessWidget {
  final String text;
  final String hinttext;
  final List<dynamic> items;
  final void Function(dynamic) callback;
  final dynamic value;

  const DropDownButtonWidget(
      {Key key,
      this.hinttext,
      this.items,
      this.callback,
      this.value,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
          child: SizedBox(
            height: 48.h,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: const BorderSide(color: Colors.black),
                  )),
              value: value,
              isExpanded: true,
              hint: Text(
                hinttext,
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items,
              onChanged: callback,
            ),
          ),
        ),
      ],
    );
  }
}
