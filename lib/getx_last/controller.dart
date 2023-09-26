import 'package:get/get.dart';

import '../log_util.dart';

class Controller extends GetxController {
  var count = 0;
  void increment() {
    count++;
    myPrint(' update...');
    update(); // count 没有使用obx
  }
}
