import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/appColor.dart';

class ErrorMessage {
  static errorMessage({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColor.redColor,
      textColor: AppColor.whiteColor,
      fontSize: 20.0,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  ///Wifi snack bar message
  static Future<SnackbarController> showSnackBarMessage({
    required String titleMessage,
    required String subtitleMessage,
    required Curve curves,
    required Widget icon,
  }) async {
    return Get.snackbar(
      titleMessage,
      subtitleMessage,
      backgroundColor: AppColor.blackColor,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(15.0),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      borderRadius: 10.0,
      reverseAnimationCurve: curves,
      colorText: AppColor.mediumGrayColor,
      icon: icon,
      padding: const EdgeInsets.all(8.0),
    );
  }
}
