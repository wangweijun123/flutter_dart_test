import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Second extends StatelessWidget {
  final Controller ctrl = Get.find();
  @override
  Widget build(context) {
    // todo 在第二个界面修改, 作用到第一个界面
    return Scaffold(body: Center(child: Text("${ctrl.count}")));
  }
}
