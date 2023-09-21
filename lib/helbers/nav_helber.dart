import 'package:flutter/material.dart';

mixin NavHelper {
  void jump(BuildContext context, Widget to, bool replace) {
    PageRouteBuilder pageRouteBuilder = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => to,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutSine;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );


    if (replace) {
      Navigator.pushReplacement(context, pageRouteBuilder);
    } else {
      Navigator.push(context, pageRouteBuilder);
    }
  }
}