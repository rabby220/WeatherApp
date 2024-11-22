import 'package:get/get.dart';
import '../controllers/dashBoard_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(
      () => DashBoardController()
    );
  }
}
