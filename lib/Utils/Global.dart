import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:words_of_culture/Utils/Colors.dart';

String appName = 'Word Of Culture';
int appVersion = 1;
void showNormalToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
      backgroundColor: const Color(0xff666666),
      textColor: pureWhiteColor,
      fontSize: 16.0);
}
