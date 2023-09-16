import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // 这是父widget
  int count = 0;

  void _incrementCounter() => setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidget 测试'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text('父widget显示的内容哈count = $count'),
          ElevatedButton(
            child: const Text('父控件改变count值'),
            onPressed: () {
              _incrementCounter();
            },
          ),
          CountContainer(
              model: this, increment: _incrementCounter, child: Counter()),
        ],
      ),
    );
  }
}

class CountContainer extends InheritedWidget {
  static CountContainer? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CountContainer>();

  final _CounterPageState model;

  final Function() increment;

  CountContainer({
    Key? key,
    required this.model,
    required this.increment,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) => model != oldWidget.model;
}

// 这是子widget, 子widget使用了父widget的属性, 第二 子widget需要修改数据
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    CountContainer state = CountContainer.of(context)!;

    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Text(
            'You have pushed the button this many times: ${state.model.count}',
          ),
          ElevatedButton(
            child: const Text('子widget修改父widget中的数据'),
            onPressed: () {
              // 只能调用父widget中方法才能同步修改状态
              state?.increment.call();

              // setState(() {
              //   state.model.count = state.model.count + 1;
              // });
            },
          ),
        ],
      ),
    );
  }
}
