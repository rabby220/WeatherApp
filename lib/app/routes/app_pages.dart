import 'package:get/get.dart';
import 'package:weather_app/app/bindings/dashBoard_binding.dart';
import 'package:weather_app/app/views/dashBoard_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String initialRoute = Routes.dashBoard;

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.dashBoard,
      page: () => const DashBoardView(),
      binding: DashBoardBinding(),
    ),

  ];
}
