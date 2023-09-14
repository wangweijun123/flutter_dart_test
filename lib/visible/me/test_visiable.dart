import 'package:flutter/material.dart';

import '../../log_util.dart';

class TestVisiable extends StatefulWidget {
  @override
  State<TestVisiable> createState() => _TestVisiableState();
}

class _TestVisiableState extends State<TestVisiable> {
  bool isVisible = true;

  void changeVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: isVisible,

              // vivisible = false, 就是android中的gone, 当然可以有下面的三个控件来是否占空间
              // maintainAnimation: true,
              // maintainSize: true,
              // maintainState: true,
              child: const Text('我是文本'),
            ),
            ElevatedButton(
              child: const Text('pageView 测试'),
              onPressed: () {
                changeVisible();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void activate() {
    super.activate();
    myPrint("_TestStatefulLifecycleState $hashCode activate ...");
  }

  @override
  void deactivate() {
    super.deactivate();
    // state这个对象被移除
    myPrint("_TestStatefulLifecycleState $hashCode deactivate ...");
  }
}
