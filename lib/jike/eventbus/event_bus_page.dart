import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:async';

import 'package:fultter_dart_sample/log_util.dart';

class CustomEvent {
  String msg;
  CustomEvent(this.msg);
}

//建立公共的event bus, 全局变量，进程在一直在, 无需关心是否为父子widget，都可以发送消息,和java中oberava与oaberable是一致的
EventBus eventBus = new EventBus();

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String msg = "通知：";
  late StreamSubscription subscription;
  @override
  void initState() {
    myPrint('eventBus.hashCode = ${eventBus.hashCode}');
    //监听CustomEvent事件，刷新UI
    subscription = eventBus.on<CustomEvent>().listen((event) {
      print(event);
      setState(() {
        msg += event.msg;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel(); //State销毁时，清理注册
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Text(msg),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondPage()))),
    );
  }
}

class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: ElevatedButton(
          child: Text('Fire Event'),
          // 触发CustomEvent事件  dynamic event
          onPressed: () => eventBus.fire(CustomEvent("hello"))),
    );
  }
}
