import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:fultter_dart_sample/multi_test.dart';
import 'package:get/get.dart';

import '../other/other_page.dart';
import 'home_page_controller.dart';

// 应用的起点
void main() => runApp(GetMaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final HomePageController c = Get.put(HomePageController());
    // 不同页面获取到的包装的controller是同一个对象
    myPrint(" c=${c.hashCode}");
    // 不能在当前页面find
    // var find = Get.find();
    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        // widget 被观察, 数据
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Column(children: [
          ElevatedButton(
              child: const Text("不同页面controller共享实例，验证数据一致性问题"),
              onPressed: () => Get.to(OtherPage())),
          ElevatedButton(
              child: const Text("跳转之前的例子"),
              onPressed: () => Get.to(const FirstRoute())),
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}
