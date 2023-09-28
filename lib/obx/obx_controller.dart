import 'dart:math';

import 'package:get/get.dart';

import '../log_util.dart';

class MyGetXController extends GetxController {
  // 数据被观察, _ 表示私有的, 就是被引入到了其他文件，不能使用
  var _count = 0.obs;
  increment() => _count++;

  int get count => _count.value;

  var _secondTxt = ''.obs;

  // 这里 => 这是个闭包, 函数安徽
  String get secondTxt => _secondTxt.value;

  void changeSecondTxt() {
    var doubleValue = Random().nextDouble() * 256;
    var secondTxt = '生成 $doubleValue';
    myPrint('setState secondTxt = $secondTxt');
    _secondTxt.value = secondTxt;
  }

  // obs 监听一个可以为null的对象
  var model = Rx<ModelMe?>(null);

  void createModel() {
    myPrint('创建ModelMe对象');
    model.value = ModelMe("duanxia");
  }
}

class ModelMe {
  String name;
  ModelMe(this.name);
}
