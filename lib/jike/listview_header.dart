import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListviewHeaderTest extends StatefulWidget {
  @override
  State<ListviewHeaderTest> createState() => _ListviewHeaderTestState();
}

class _ListviewHeaderTestState extends State<ListviewHeaderTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List view header'),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //SliverAppBar作为头图控件
          title: const Text('CustomScrollView Demo'), //标题
          floating: true, //设置悬浮样式
          flexibleSpace:
              Image.network("https://xx.jpg", fit: BoxFit.cover), //设置悬浮头图背景
          expandedHeight: 300, //头图控件高度
        ),
        SliverList(
          //SliverList作为列表控件
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text('Item #$index')), //列表项创建方法
            childCount: 100, //列表元素个数
          ),
        ),
      ]),
    );
  }
}
