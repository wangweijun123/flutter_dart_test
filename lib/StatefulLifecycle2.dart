import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'log_util.dart';

// ctrol + enter 修改成StatefulWidget
class TestStatefulLifecycle2 extends StatefulWidget {
  const TestStatefulLifecycle2({super.key});

  @override
  State<TestStatefulLifecycle2> createState() => _TestStatefulLifecycle2State();
}

class _TestStatefulLifecycle2State extends State<TestStatefulLifecycle2> {
  int num = 0;
  // 常量如果在类级别，需要加 static
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  void changeNumber() {
    setState(() {
      num++;
    });
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      var argments = {"id": "010", "userName": "wwj"};
      final int result =
          await platform.invokeMethod('getBatteryLevel', argments);
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    myPrint("_TestStatefulLifecycle2State $hashCode initState ...");
    registerMethod();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myPrint("_TestStatefulLifecycle2State $hashCode didChangeDependencies ...");
  }

  @override
  void didUpdateWidget(covariant TestStatefulLifecycle2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    myPrint("_TestStatefulLifecycle2State $hashCode didUpdateWidget ...");
  }

  // 需要快点进入注册这个方法，不然dart端还没有注册， kotlin以及发送了
  void registerMethod() {
    platform.setMethodCallHandler((call) async {
      if (call.method == "getDartVersion") {
        myPrint("flutter_xxxx reply to dart version");
        return getDartVersion();
      }
      return "not support version";
    });
  }

  String getDartVersion() => 'dart 1.0';

  @override
  void activate() {
    super.activate();
    myPrint("_TestStatefulLifecycle2State $hashCode activate ...");
  }

  @override
  void deactivate() {
    super.deactivate();
    // state这个对象被移除
    myPrint("_TestStatefulLifecycle2State $hashCode deactivate ...");
  }

  @override
  void dispose() {
    super.dispose();
    myPrint("_TestStatefulLifecycle2State $hashCode dispose ...");
  }

  @override
  Widget build(BuildContext context) {
    myPrint("_TestStatefulLifecycle2State $hashCode build ...");
    // 放到子控件的名字上，按下 alt + entry 来新增加一个父层次
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildSingleColumn(),
            buildSingleRow(),
            buildBattery(),
          ],
        ),
      ),
    );
  }

  Column buildBattery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _getBatteryLevel,
          child: const Text('Get Battery Level'),
        ),
        Text(_batteryLevel),
      ],
    );
  }

  Row buildSingleRow() {
    return Row(
      // 列的主轴线指的是横向
      mainAxisAlignment: MainAxisAlignment.end,
      // 对轴
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // text 本身是无状态的文本，如何变成可以修改
        Text('num = $num'),
        TextButton(
            onPressed: () {
              changeNumber();
            },
            child: const Text("测试stateful组件的生命周期")),
      ],
    );
  }

  Column buildSingleColumn() {
    return Column(
      // 列的主轴线指的是在垂直方向
      // mainAxisAlignment: MainAxisAlignment.start,

      // 对轴
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // text 本身是无状态的文本，如何变成可以修改
        Text('num = $num'),
        TextButton(
            onPressed: () {
              changeNumber();
            },
            child: const Text("测试stateful组件的生命周期")),
      ],
    );
  }

  //最外层 Column占满整个屏幕，内层wrap子控件高度
  Column buildMultiColumn() {
    return Column(
      children: [
        Column(
          // 列的主轴线指的是在垂直方向
          // mainAxisAlignment: MainAxisAlignment.start,

          // 横轴
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text 本身是无状态的文本，如何变成可以修改
            Text('num = $num'),
            TextButton(
                onPressed: () {
                  changeNumber();
                },
                child: const Text("测试stateful组件的生命周期")),
          ],
        ),
        Column(
          // 列的主轴线指的是在垂直方向
          // mainAxisAlignment: MainAxisAlignment.start,

          // 横轴
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text 本身是无状态的文本，如何变成可以修改
            Text('num = $num'),
            TextButton(
                onPressed: () {
                  changeNumber();
                },
                child: const Text("测试stateful组件的生命周期")),
          ],
        ),
      ],
    );
  }
}
