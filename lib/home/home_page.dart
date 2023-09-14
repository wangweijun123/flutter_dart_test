import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:fultter_dart_sample/multi_test.dart';
import 'package:get/get.dart';

import '../other/other_page.dart';
import 'home_page_controller.dart';

// 应用的起点
void main() => runApp(GetMaterialApp(home: HomePage()));

// 使用StatelessWidget并节省一些RAM，有了Get你可能不再需要使用StatefulWidget。
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
          Obx(() => Text(c.user.value.name)),
          ElevatedButton(
              child: const Text("Obx操作对象测试"),
              onPressed: () {
                print('更新username   ddddddddd');
                c.updateUserName();
              }),
          ElevatedButton(
              // 不是叠加
              child: const Text("两个异步任务是并行的吗，时间是叠加的吗?"),
              onPressed: () {
                testDelay();
              }),
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }

  void testDelay() {
    myPrint('click button ...');
    delayExcute(3);
    delayExcute(2);
  }

  // 模拟耗时任务，多个任务是在线程池执行，而调用端只是获取结果而已，不用担心线程的问题了，简单多了
  // io, net 都这样写就行了把

  Future<void> delayExcute(int num) async {
    // await 是阻塞当前函数，不阻塞调用栈上层
    var order = await Future.delayed(
      Duration(seconds: num),
      () => 'time = $num',
    );
    myPrint('Your order is: $order');
  }
}
