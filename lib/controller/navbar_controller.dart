// navbar_controller.dart
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;
  var isVisible = true.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }

  void hideNavbar() => isVisible.value = false;
  void showNavbar() => isVisible.value = true;
}