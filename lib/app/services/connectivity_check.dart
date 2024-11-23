import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/utils/appIcon.dart';
import 'package:weather_app/app/utils/appText.dart';
import 'errorMessage.dart';

class ConnectivityService extends GetxService {
  StreamSubscription? subscription;

  /// Checks connectivity status and shows a message only if no internet.
  Future<void> checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Show message only if no internet at startup
      ErrorMessage.showSnackBarMessage(
        titleMessage: AppText.noInternetTitleText,
        subtitleMessage: AppText.noInternetSubtitleText,
        curves: Curves.elasticInOut,
        icon: Icon(AppIcon.wifiOffIcon, color: Colors.white),
      );
    }
  }

  @override
  void onInit() {
    // Start listening for connectivity changes (optional)
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      // Show messages only when connectivity status changes
      if (result == ConnectivityResult.none) {
        ErrorMessage.showSnackBarMessage(
          titleMessage: AppText.noInternetTitleText,
          subtitleMessage: AppText.noInternetSubtitleText,
          curves: Curves.elasticInOut,
          icon: Icon(AppIcon.wifiOffIcon, color: Colors.white),
        );
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
