import 'package:get/get.dart';
import 'package:kurs_cash/controllers/curs_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CursController());
  }
}
