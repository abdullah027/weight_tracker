

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigation {
  static void navigateToRemovingAll(context, Widget widget) async {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: widget,
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 700)),
            (Route<dynamic> route) => false);
  }

  static void navigateTo(BuildContext context, Widget widget) async {
    Navigator.push(
        context,
        PageTransition(
            child: widget,
            type: PageTransitionType.fade,
            opaque: true,
            duration: Duration(milliseconds: 700)));
  }

  static void navigateReplacement(BuildContext context, Widget widget) async {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: widget,
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 700)));
  }

  static Future<dynamic> navigateToUpdate(
      BuildContext context, Widget widget) async {
    dynamic value = await Navigator.of(context).push(PageTransition(
        child: widget,
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 700)));
    //     .then((String value) {
    //   print("Value is"+value.toString());
    //   return value;
    // });
    return value;
  }

  static void navigatorPop(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateCloseDialog(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void navigatorPopTrue(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  static void navigatorPopData(BuildContext context, dynamic data) {
    Navigator.of(context).pop(data);
  }

  static void navigatorPopFalse(BuildContext context) {
    Navigator.of(context).pop(false);
  }
}
