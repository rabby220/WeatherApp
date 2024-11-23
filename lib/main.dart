import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/connectivity_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the ConnectivityService before running the app
   //await Get.putAsync(() async => ConnectivityService());


  // Initialize the ConnectivityService and check connectivity on startup
  ConnectivityService connectivityService = Get.put(ConnectivityService());
  await connectivityService.checkInitialConnectivity();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
    ),
  );
}
