import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CallBack = Function(dynamic _);

class MyDropDon extends StatefulWidget {
  final dynamic value;
  final List<dynamic>? list;
  final String? hint;
  final CallBack callBack;

  const MyDropDon(
      {Key? key, this.list, this.hint, this.value, required this.callBack})
      : super(key: key);

  @override
  State<MyDropDon> createState() => _MyDropDonState();
}

class _MyDropDonState extends State<MyDropDon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(5.r),
          border: Border.all(width: 1.w, color: Colors.grey.shade300)),
      child: DropdownButton<dynamic>(
        value: widget.value,
        isExpanded: true,
        hint: Text(widget.hint ?? ''),
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        // padding: EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 10.w),
        items: widget.list!.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.name));
        }).toList(),
        onChanged: (value) => widget.callBack(value),
      ),
    );
    ;
  }
}
