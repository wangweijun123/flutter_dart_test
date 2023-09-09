import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import 'obx_controller.dart';
import 'package:get/get.dart';

/// dart 页面编写原则, 一个页面肯定有多个变化有多个不变化的widget，变化的ui必须抽出来，自己管理状态，刷新的时候不会其他widget的re build
///
class OBXTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    myPrint('OBXTest $hashCode build ... ');
    return MaterialApp(
      title: 'OBXTest demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OBXTest demo'),
        ),
        body: Center(child: BodyUi2()),
      ),
    );
  }
}

class BodyUi2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    myPrint('BodyUi2 $hashCode build ... ');
    final MyGetXController controller = MyGetXController();

    return Column(
      children: [
        // Obx is StatefulWidget 包装可变化的组件, 其实根本问题是它帮助你包装了StatelessWidget
        // 1 如果是debug, 这个时候需要重新安装apk，不能在hotreload下debug
        // 2 attach 进程后, debug 连接不上, kill app, start
        Obx(() {
          myPrint('改变了controller 中的obx变量，这里被调用了 ... ');
          return controller.count == 0
              ? Container()
              : Text('count = ${controller.count}');
        }),
        ElevatedButton(
            onPressed: () {
              controller.increment();
            },
            child: Text('刷新第一个text')),

        Obx(() => controller.secondTxt.isEmpty
            ? Container()
            : Text(controller.secondTxt)),

        ElevatedButton(
            onPressed: () {
              controller.changeSecondTxt();
            },
            child: Text('刷新第二个text')),
      ],
    );
  }
}
