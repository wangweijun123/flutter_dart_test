import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../log_util.dart';

class ListviewYouhuaTest extends StatefulWidget {
  @override
  State<ListviewYouhuaTest> createState() => _ListviewYouhuaTestState();
}

class _ListviewYouhuaTestState extends State<ListviewYouhuaTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 没有设置cacheExtent(缓存的高度), build到了index = 21(从0开始), 一屏幕可以显示16, 相当于缓存了5个
    // 设置 cacheExtent = 800, 也就是 缓存了16个item,  build到了index = 32(从0开始)
    return SafeArea(
      child: Scaffold(
          body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 100, //元素个数
        cacheExtent: 800,
        itemExtent: 50.0, // 强烈建议确定列表项高度(确定item高度, 省去)，
        // 如果为null，会根据子 widget创建完成才能确定的高度，以及滑动的位置, 定 itemExtent 比让子 Widget 自己决定自身高度会更高效
        itemBuilder: (BuildContext context, int index) {
          myPrint("index 没有设置cache =  $index .");
          return ListTile(
              title: Text("title $index"), subtitle: Text("body $index"));
        },
      )),
    );
  }
}
