import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/exception/exception_page.dart';

/// 同步错误  异步错误的捕获 同步的 try-catch 和异步的 catchError
class ExceptionTest extends StatefulWidget {
  @override
  State<ExceptionTest> createState() => _ExceptionTestState();
}

class _ExceptionTestState extends State<ExceptionTest> {
  @override
  Widget build(BuildContext context) {
    // ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    //   return Scaffold(
    //       body: Center(
    //         child: Text("Custom Error Widget"),
    //       ));
    // };

    return Scaffold(
      appBar: AppBar(
        title: const Text('exception'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('同步异常奔溃吗???'),
            onPressed: () {
              syncException();
            },
          ),
          ElevatedButton(
            child: const Text('捕获同步exeption'),
            onPressed: () {
              catchSyncException();
            },
          ),
          ElevatedButton(
            child: const Text('捕获异步exeption'),
            onPressed: () {
              catchAsyncException();
            },
          ),
          ElevatedButton(
            child: const Text('try catch无法捕获异步exeption'),
            onPressed: () {
              canNotCatch();
            },
          ),
          ElevatedButton(
            child: const Text('这样写可以捕获异步异常'),
            onPressed: () {
              canCatch2();
            },
          ),
          ElevatedButton(
            child: const Text('使用Zone 区域来捕获同步异常'),
            onPressed: () {
              useZoneCatchSyncException();
            },
          ),
          ElevatedButton(
            child: const Text('使用Zone 区域来捕获异步异常'),
            onPressed: () {
              useZoneCatchSyncException();
            },
          ),
          ElevatedButton(
            child: const Text('跳转异常界面....'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExceptionPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void syncException() {
    // dart不强制捕获异常，dart上面的异常不奔溃
    throw StateError('This is a Dart exception.');
  }

  void catchSyncException() {
    //使用try-catch捕获同步异常, 没有问题
    try {
      throw StateError('This is a Dart exception. no problem');
    } catch (e) {
      print(e);
    }
  }

  void catchAsyncException() async {
    //使用catchError捕获异步异常
    var result = await Future.delayed(Duration(seconds: 1))
        .then((e) => throw StateError('This is a Dart exception in Future.'))
        .catchError((e) => print('here e = $e'));
    print('result = $result');
  }

  void canNotCatch() {
    //注意，以下代码无法捕获异步异常，但是app
    try {
      print("executed async task ....");
      Future.delayed(Duration(seconds: 1))
          .then((e) => throw StateError('This is a Dart exception in Future.'));
    } catch (e) {
      print("This line will never be executed. ");
    }
  }

  Future<void> canCatch2() async {
    // 但是这样可以哈, 因为await吗？？
    try {
      print("executed async task ....");
      var result = await Future.delayed(Duration(seconds: 1))
          .then((e) => throw StateError('This is a Dart exception in Future.'));
      print('result = $result');
    } catch (e) {
      print("This line will be executed. ");
    }
  }

  void useZoneCatchSyncException() {
    runZoned(() {
      //同步抛出异常
      throw StateError('This is a Dart exception.');
    }, onError: (dynamic e, StackTrace stack) {
      print('Sync error caught by zone');
    });
  }

  void useZoneCatchAsyncException() {
    runZoned(() {
      //异步抛出异常
      Future.delayed(Duration(seconds: 1))
          .then((e) => throw StateError('This is a Dart exception in Future.'));
    }, onError: (dynamic e, StackTrace stack) {
      print('Async error aught by zone');
    });
  }
}
