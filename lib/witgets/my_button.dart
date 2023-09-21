import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final bool isBorder;
  final double sizeText;
  final Color? colorButton;
  final Function()? onTap;
  final bool loader;
  final FontWeight? fontWeight;

  const MyButton({
    required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.isBorder = false,
    this.sizeText = 18,
    this.fontWeight,
    this.loader = false,
    this.onTap,
    this.colorButton,
    super.key,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: !widget.loader ? widget.onTap : null,
      child: widget.loader == true
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Theme.of(context).primaryColor,
                secondRingColor: Colors.orange,
                thirdRingColor: Colors.deepOrangeAccent,
                size: 30.h,
              ),)
          : Container(
              width: widget.width.w,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.isBorder != true
                    ? widget.colorButton
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: widget.isBorder == true
                    ? Border.all(
                        width: 1, color: Theme.of(context).primaryColor)
                    : null,
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.isBorder == false
                          ? Colors.white
                          : Colors.green,
                      fontSize: widget.sizeText.sp,
                      fontWeight: widget.fontWeight),
                ),
              ),
            ),
    );
  }
}
