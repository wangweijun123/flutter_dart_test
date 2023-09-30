import 'package:flutter/material.dart';

import '../log_util.dart';
import 'cake.dart';
import 'cake2.dart';
import 'update_item.dart';
import 'update_item_model.dart';

class LayoutTest extends StatefulWidget {
  @override
  State<LayoutTest> createState() => _LayoutTestState();
}

class _LayoutTestState extends State<LayoutTest> {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
                padding: EdgeInsets.all(18.0), // 内边距
                margin: EdgeInsets.all(44.0), // 外边距
                width: 180.0,
                height: 240,
                alignment: Alignment.center, // 子Widget居中对齐
                decoration: BoxDecoration(
                  //Container样式
                  color: Colors.red, // 背景色
                  borderRadius: BorderRadius.circular(10.0), // 圆角边框
                ),
              ),
              Padding(
                padding: EdgeInsets.all(44.0),
                child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
              ),
              //Row的用法示范
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //由于容器与子Widget一样宽，因此这行设置排列间距的代码并未起作用
                mainAxisSize: MainAxisSize.min, //让容器宽度与所有子Widget的宽度一致
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    width: 60,
                    height: 80,
                  ),
                  Container(
                    color: Colors.red,
                    width: 100,
                    height: 180,
                  ),
                  Container(
                    color: Colors.black,
                    width: 60,
                    height: 80,
                  ),
                  Container(
                    color: Colors.green,
                    width: 60,
                    height: 80,
                  ),
                ],
              ),

//Column的用法示范
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    width: 60,
                    height: 80,
                  ),
                  Container(
                    color: Colors.red,
                    width: 100,
                    height: 180,
                  ),
                  Container(
                    color: Colors.black,
                    width: 60,
                    height: 80,
                  ),
                  Container(
                    color: Colors.green,
                    width: 60,
                    height: 80,
                  ),
                ],
              ),

              Stack(
                children: <Widget>[
                  Container(
                      color: Colors.yellow, width: 300, height: 300), //黄色容器
                  Positioned(
                    left: 18.0,
                    top: 18.0,
                    child: Container(
                        color: Colors.green,
                        width: 50,
                        height: 50), //叠加在黄色容器之上的绿色控件
                  ),
                  Positioned(
                    left: 18.0,
                    top: 70.0,
                    child: Text("Stack提供了层叠布局的容器"), //叠加在黄色容器之上的文本
                  )
                ],
              ),

              UpdatedItem(
                model: UpdatedItemModel(
                    appDate: '12.12',
                    appDescription:
                        'this is des,xxddddddddddddddddddddddddddddddddeeeeeeffffadfadfaczvzcv2333',
                    appIcon: 'images/pic1.jpg',
                    appName: 'google',
                    appSize: '18M',
                    appVersion: '1.0.2'),
                onPressed: () {},
              ),

              Cake(),
              Cake2(),
            ],
          ),
        ),
      ),
    );
  }
}
