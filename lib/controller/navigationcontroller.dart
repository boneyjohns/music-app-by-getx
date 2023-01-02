import 'package:get/get.dart';

class Navigationcontroller extends GetxController {
  RxInt selectedindex = 0.obs;

  bottomChange(int index) {
    selectedindex.value = index;
  }
}
