import 'package:flutter/material.dart';

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
      ]),
    );
  }
}