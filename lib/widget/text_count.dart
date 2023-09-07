import 'package:flutter/material.dart';

class TextCount extends StatelessWidget {
  final String text;
  final String num;
  final TextStyle textStyle;
  final TextStyle numStyle;

  // alt + insert 生成构造函数
  const TextCount(this.text, this.num,
      {super.key,
      this.textStyle = const TextStyle(
        color: Colors.black,
      ),
      this.numStyle = const TextStyle(
        color: Colors.red,
      )});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: textStyle,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          num,
          style: numStyle,
        )
      ],
    );
  }
}
