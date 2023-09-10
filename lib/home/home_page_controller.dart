import 'dart:math';

import 'package:get/get.dart';

import 'user_model.dart';

class HomePageController extends GetxController {
  // 数据被观察
  var count = 0.obs;
  increment() => count++;

  final user = User(name: 'John', last: 'Doe', age: 33).obs;

  /// obs如果是对象，更新方式不一样
  void updateUserName() {
    user.value.name = '随机名字${Random().nextDouble()}';
    user.refresh();
  }
}
