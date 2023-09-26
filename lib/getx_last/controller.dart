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

  void updateItem(User user) {
    for (var element in list) {
      if (element.id == user.id) {
        myPrint("修改");
        element.name = '${user.id} 被修改了';
        break;
      }
    }

    printlist();
  }

  void printlist() {
    for (var element in list) {
      myPrint(element.toString());
    }
  }
}
