import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../log_util.dart';

class IsolateTest extends StatefulWidget {
  @override
  State<IsolateTest> createState() => _IsolateTestState();
}

class _IsolateTestState extends State<IsolateTest> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 100,
        ),
        ElevatedButton(
          child: Text('isolate test'),
          onPressed: computeJIcheng,
        ),
      ],
    );
  }
}

void computeJIcheng() async {
  myPrint('start compute ...');
  var result = await compute(syncFactorial, 4);
  myPrint('result = $result');
}

// 同步计算阶乘, cpu 密集型任务,在另外的isolate进行work, 充分利用cpu 多核
/// Dart 是单线程的，但通过事件循环可以实现异步。而 Future 是异步任务的封装，借助于 await 与 async，
/// 我们可以通过事件循环实现非阻塞的同步等待；Isolate 是 Dart 中的多线程，可以实现并发，有自己的事件循环与 Queue，
/// 独占资源。Isolate 之间可以通过消息机制进行单向通信，这些传递的消息通过对方的事件循环驱动对方进行异步处理。
int syncFactorial(n) => n < 2 ? n : n * syncFactorial(n - 1);
