import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:fultter_dart_sample/multi_test.dart';
import 'package:get/get.dart';

import '../other/other_page.dart';
import 'home_page_controller.dart';

// Widget _defaultErrorWidgetBuilder(FlutterErrorDetails details) {
//   print('显示自定义的error page');
//   String message =
//       '${details.exception}\nSee also: https://flutter.dev/docs/testing/errors';
//
//   final Object exception = details.exception;
//   return ErrorWidget.withDetails(
//       message: message, error: exception is FlutterError ? exception : null);
// }
int totalPV = 0;

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    totalPV++;
    // 能获取之前的路由和current的路由
    myPrint(
        " 统计页面跳转次数 totalPV=$totalPV, route=${route.settings.name}, previousRoute=${previousRoute?.settings.name}");
  }
}

// 应用的起点
void main() {
  // 自定义错误界面不起作用
  // ErrorWidget.builder = _defaultErrorWidgetBuilder;

  runApp(GetMaterialApp(
    home: HomePage(),
    navigatorObservers: [MyObserver()],
  ));
}

// 使用捕获未catch 异常机制来启动app, 发现捕获不了，为什么???
// void main() => runZoned<Future<Null>>(() async {
//       runApp(MaterialApp(home: HomePage()));
//     }, onError: (error, stackTrace) async {
//       //Do sth for error
//       print('app 入口获取到了未捕获异常 $error');
//     });

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
