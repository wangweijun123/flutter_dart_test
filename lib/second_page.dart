import 'package:flutter/material.dart';

import 'gen/assets.gen.dart';
import 'third_page.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    print("获取到参数id = ${params['id']}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
        ElevatedButton(
          onPressed: () {
            // 按下back键或button，都会回到 上一个界面调用的地方的await或者then
            Navigator.pop(context, 'this is result for back');
          },
          child: const Text('Go back with parmas'),
        ),
        ElevatedButton(
          onPressed: () {
            print("click me");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            );
          },
          child: const Text('测试listview'),
        ),
        Image.asset(
          'asset/image/girl.jpg',
          width: 250,
          height: 250,
        ),
        // 如果在项目中新增资源图片,重新生成gen目录 需要 1 flutter clean 2 flutter pub get 3 flutter packages pub run build_runner build
        Image.asset(
          Assets.image.girl.path,
          width: 250,
          height: 250,
        ),
      ]),
    );
  }
}
