import 'package:get/get.dart';
import '../controller/navbar_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
  }
}