import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

/// InheritedWidget。对于视图层级比较深的 UI 样式，直接通过属性传值的方式会导致很多中间层增加冗余属性
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
    myPrint('_CounterPageState 父widget build....');
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
              counterPageState: this,
              increment: _incrementCounter,
              child: Counter()),
        ],
      ),
    );
  }
}

/// 继承InheritedWidget是功能形的widget，并没有可绘制的widget,
/// CountContainer 保存了 父widget的 数据，这里是保存 父widget管理的state对象
///  适合 子widget 读取 父widget的数据, 数据流向是从父到儿子 (当前页面)
///
class CountContainer extends InheritedWidget {
  // 静态方法返回自己
  static CountContainer? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CountContainer>();

  final _CounterPageState counterPageState;

  final Function() increment;

  CountContainer({
    Key? key,
    required this.counterPageState,
    required this.increment,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) =>
      counterPageState != oldWidget.counterPageState;
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
    myPrint('_CounterState 子widget build....state = ${state.hashCode}');
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Text(
            'You have pushed the button this many times: ${state.counterPageState.count}',
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
          const SizedBox(
            height: 50,
          ),
          SonSon()
        ],
      ),
    );
  }
}

class SonSon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountContainer state = CountContainer.of(context)!;
    myPrint('_CounterState 子widget build....state = ${state.hashCode}');
    return Text('我是曾孙子哦 count = ${state.counterPageState.count}');
  }
}
