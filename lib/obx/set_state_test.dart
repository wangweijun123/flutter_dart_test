import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

/// dart 页面编写原则, 一个页面肯定有多个变化有多个不变化的widget，变化的ui必须抽出来
/// 自己管理状态，刷新的时候不会其他widget的re build
/// Obx 帮你包装了 stateful widget
class SetStateTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    myPrint('SetStateTest $hashCode build ... ');
    return MaterialApp(
      title: 'list or gride layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('set state demo'),
        ),
        body: Center(child: BodyUi()),
      ),
    );
  }
}

class BodyUi extends StatefulWidget {
  @override
  State<BodyUi> createState() => _BodyUiState();
}

class _BodyUiState extends State<BodyUi> {
  String id = '';

  void changeIdUi() {
    setState(() {
      var doubleValue = Random().nextDouble() * 256;
      id = '生成 $doubleValue';
      myPrint('setState id = $id');
    });
  }

  @override
  Widget build(BuildContext context) {
    myPrint('_BodyUiState $hashCode build ... ');
    return Column(
      children: [
        FirstUIChange(),
        SecondUiChange(),
        const Text('xxxxx'),
        const Text('xxxxx'),

        // 这个Row组件必须抽出来, 刷新的不然会导致上面的widget刷新，性能低下
        // 在这个场景下，所以出现了Obx, 改造一下
        Row(
          children: [
            id.isEmpty ? Container() : Text(id),
            ElevatedButton(
                onPressed: () {
                  changeIdUi();
                },
                child: Text('刷新id')),
          ],
        ),
        Text('xxxxx'),
      ],
    );
  }
}

class FirstUIChange extends StatefulWidget {
  @override
  State<FirstUIChange> createState() => _FirstUIChangeState();
}

class _FirstUIChangeState extends State<FirstUIChange> {
  String firstTxt = '';

  void changeFirstTxt() {
    setState(() {
      var doubleValue = Random().nextDouble() * 256;
      firstTxt = '生成 $doubleValue';
      myPrint('setState firstTxt = $firstTxt');
    });
  }

  @override
  Widget build(BuildContext context) {
    myPrint('_FirstUIChangeState $hashCode build ... ');
    return Column(
      children: [
        // 运算符在widget中判断
        firstTxt.isEmpty ? Container() : Text(firstTxt),
        ElevatedButton(
            onPressed: () {
              changeFirstTxt();
            },
            child: Text('刷新第一个text')),
      ],
    );
  }
}

class SecondUiChange extends StatefulWidget {
  @override
  State<SecondUiChange> createState() => _SecondUiChangeState();
}

class _SecondUiChangeState extends State<SecondUiChange> {
  String secondTxt = '';

  void changeSecondTxt() {
    setState(() {
      var doubleValue = Random().nextDouble() * 256;
      secondTxt = '生成 $doubleValue';
      myPrint('setState secondTxt = $secondTxt');
    });
  }

  @override
  Widget build(BuildContext context) {
    myPrint('_SecondUiChangeState $hashCode build ... ');
    return Column(
      children: [
        // 运算符在widget中判断
        secondTxt.isEmpty ? Container() : Text(secondTxt),
        ElevatedButton(
            onPressed: () {
              changeSecondTxt();
            },
            child: Text('刷新第二个text')),
      ],
    );
  }
}
