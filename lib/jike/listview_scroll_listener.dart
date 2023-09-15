import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListviewScrollStateListenerTest extends StatefulWidget {
  @override
  State<ListviewScrollStateListenerTest> createState() =>
      _ListviewScrollStateListenerStateTest();
}

class _ListviewScrollStateListenerStateTest
    extends State<ListviewScrollStateListenerTest> {
  late ScrollController _controller; //ListView控制器
  bool isToTop = false; //标示目前是否需要启用"Top"按钮
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      //为控制器注册滚动监听方法
      if (_controller.offset > 1000) {
        //如果ListView已经向下滚动了1000，则启用Top按钮
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        //如果ListView向下滚动距离不足300，则禁用Top按钮
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 100,
          //元素个数
          itemExtent: 50.0,
          // 强烈建议确定列表项高度(确定item高度, 省去)， 如果为null，会根据子 widget创建完成才能确定的高度，以及滑动的位置, 定 itemExtent 比让子 Widget 自己决定自身高度会更高效
          itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text("title $index"), subtitle: Text("body $index"))),
    );
  }
}
