import 'package:get/get.dart';

class HomePageController extends GetxController {
  // 数据被观察
  var count = 0.obs;
  increment() => count++;
}
