import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class RichTextTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle blackStyle = const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 40,
        color: Colors.black); //黑色样式
    TextStyle redStyle = const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); //红色样式

    return Scaffold(
      appBar: AppBar(
        title: const Text('这是rich text展示'),
      ),
      body: Column(
        children: [
          Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(
                  text: '文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似',
                  style: redStyle), //第1个片段，红色样式
              TextSpan(text: 'Android', style: blackStyle), //第1个片段，黑色样式
              TextSpan(text: '中的', style: redStyle), //第1个片段，红色样式
              TextSpan(text: 'TextView', style: blackStyle) //第1个片段，黑色样式
            ]),
            textAlign: TextAlign.center,
          ),
          // 网络站位图
          FadeInImage(
            width: 200,
            height: 200,
            // here `bytes` is a Uint8List containing the bytes for the in-memory image
            placeholder: AssetImage(Assets.image.avatar.path),
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          ),

          ///
        ],
      ),
    );
  }
}
