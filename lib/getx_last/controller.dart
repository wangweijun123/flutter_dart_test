import 'package:get/get.dart';
import 'list/user.dart';
import '../log_util.dart';

class Controller extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
    // myPrint(' update...');
    // update(); // count 没有使用obx
  }

  final list = <User>[].obs;

  int num = 0;
  incrementList() {
    var temp = <User>[];
    for (int i = 0; i < 10; i++) {
      temp.add(User(num, 'index = $num'));
      num++;
    }
    list.addAll(temp);
  }
}
