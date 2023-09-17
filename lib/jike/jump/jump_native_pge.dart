import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestJumpNativePage extends StatelessWidget {
  // 常量如果在类级别，需要加 static
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        ElevatedButton(
          child: const Text('测试stateful组件的生命周期'),
          onPressed: () {
            jumpNative();
          },
        ),
      ],
    );
  }

  Future<void> jumpNative() async {
    final result = await platform.invokeMethod('openNativePage', "xxxxx");
    print('flutter_xxxx result = $result ');
  }
}
