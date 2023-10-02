import 'package:flutter/material.dart';
import 'counter_model.dart';
import 'package:provider/provider.dart';
import 'test_icon.dart';

/// Provider 提供页面之间提供数据共享，其实很简单，两个页面能获取这个实例并且通知到变化就行了
/// Provider.of<XXXXX>()
class ProviderTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    print("ProviderTabPage1 build CounterModel = ${_counter.hashCode}");
    final textSize = Provider.of<double>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          'Counter: ${_counter.counter}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProviderTabPage2())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ProviderTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    print("ProviderTabPage2 build  CounterModel = ${_counter.hashCode}");
    final textSize = Provider.of<double>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Text(
        'Counter: ${_counter.counter}',
        style: TextStyle(fontSize: textSize),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counter.increment,
        child: TestIcon(),
      ),
    );
  }
}
