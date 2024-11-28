import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/utils/appIcon.dart';
import 'package:weather_app/app/utils/appText.dart';

import 'errorMessage.dart';

class ConnectivityService extends GetxService {
  StreamSubscription? subscription;

  /// Checks connectivity when the app starts.
  Future<void> checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetMessage(); // Show message only if no internet at startup
    }
  }

  /// Called when there's no internet
  void _showNoInternetMessage() {
    ErrorMessage.showSnackBarMessage(
      titleMessage: AppText.noInternetTitleText,
      subtitleMessage: AppText.noInternetSubtitleText,
      curves: Curves.elasticInOut,
      icon: Icon(AppIcon.wifiOffIcon, color: Colors.white),
    );
  }

  @override
  void onInit() {
    // Listen for connectivity changes
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _showNoInternetMessage(); // Show message if internet is lost
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel(); // Cancel subscription when not needed
    super.onClose();
  }
}
