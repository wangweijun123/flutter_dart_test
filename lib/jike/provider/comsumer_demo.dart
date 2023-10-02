import 'package:flutter/material.dart';
import 'counter_model.dart';
import 'package:provider/provider.dart';
import 'test_icon.dart';

/**
 * Provider(InherieWidget) 与 consumer 连用, 比较起来getx, obs
 */
class ConsumerTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ConsumerTabPage1 build");
    final _counter = Provider.of<CounterModel>(context);
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
            .push(MaterialPageRoute(builder: (context) => ConsumerTabPage2())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ConsumerTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ConsumerTabPage2 build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Consumer2<CounterModel, double>(
          builder: (context, CounterModel counter, double textSize, _) {
        print("ConsumerTabPage2 局部刷新 text");
        return Text('Counter: ${counter.counter}',
            style: TextStyle(fontSize: textSize));
      }),
      floatingActionButton: Consumer<CounterModel>(
        // Consumer 包了一层
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter
              .increment, // 自己刷新(ConsumerTabPage2 局部刷新 text)，同时导致ConsumerTabPage1 build
          child: child,
        ),
        child: TestIcon(),
      ),
    );
  }
}
