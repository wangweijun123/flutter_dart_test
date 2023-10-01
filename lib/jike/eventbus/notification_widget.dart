import 'package:flutter/material.dart';

// InheritedWidget 与 Notification 都只适合在父子widget关系
// InheritedWidget 数据流 父widget  ---> 子 widget
// Notification    数据流 父widget  <--- 子 widget
//  如果是页面之间    eventbus

class CustomNotification extends Notification {
  CustomNotification(this.msg);
  final String msg;
}

class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          //按钮点击时分发通知，通知到了父widget，数据流从 子widget 传到父 widget
          onPressed: () => CustomNotification("Hi").dispatch(context),
          child: Text("Fire Notification"),
        ),
        CustomChilChild(),
      ],
    );
  }
}

class CustomChilChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //按钮点击时分发通知，通知到了父widget，数据流从 子widget 传到父 widget
      onPressed: () => CustomNotification("Hi").dispatch(context),
      child: Text("CustomChilChild Fire Notification"),
    );
  }
}

// 父widget
class NotificationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  String _msg = "通知：";
  @override
  Widget build(BuildContext context) {
    //监听通知, 监听从子widget发送消息到父widget的场景
    return NotificationListener<CustomNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "  ";
          });
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_msg), CustomChild()],
        ));
  }
}
