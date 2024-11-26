import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/app/theme/appTheme.dart';

import 'app/routes/app_pages.dart';
import 'app/services/connectivity_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Local Data base Initialization
  await Hive.initFlutter();
  await Hive.openBox('PeopleBox');

  // Initialize the ConnectivityService before running the app
  //await Get.putAsync(() async => ConnectivityService());

  // Initialize the ConnectivityService and check connectivity on startup
  ConnectivityService connectivityService = Get.put(ConnectivityService());
  await connectivityService.checkInitialConnectivity();

  runApp(
    ValueListenableBuilder(
      valueListenable: Hive.box('PeopleBox').listenable(),
      builder: (context, box, child) {
        final isDark = box.get('isDark', defaultValue: false);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.routes,
          theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        );
      },
    ),
  );
}
