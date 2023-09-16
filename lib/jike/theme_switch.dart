// class ThemeSwitch

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyThemePage());

class MyThemePage extends StatelessWidget {
  // 自定义theme data, 给widget使用，定义样式

  // iOS 浅色主题
  final ThemeData kIOSTheme = ThemeData(
      brightness: Brightness.light,
      primaryColorLight: Colors.white,
      primaryColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.grey),
      textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)));

  // Android 深色主题
  final ThemeData kAndroidTheme = ThemeData(
      brightness: Brightness.dark, // 深色主题
      primaryColorLight: Colors.black, //(按钮)Widget 前景色为黑色,  accentColor这个编译不过
      primaryColor: Colors.cyan, // 主题色为青色
      iconTheme: IconThemeData(color: Colors.blue), //icon 主题色为蓝色
      textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.red)) // 文本主题色为红色
      );

  Widget build(BuildContext context) {
    var theme = MyTheme(
      title: 'Flutter Demo Home Page',
      themes: [kIOSTheme, kAndroidTheme],
    );
    return MaterialApp(
      title: 'My Theme',
      theme: kAndroidTheme,
      home: theme,
    );
  }
}

class MyTheme extends StatefulWidget {
  MyTheme({Key? key, required this.title, required this.themes})
      : super(key: key);

  final String title;
  final List<ThemeData> themes;

  _MyThemeState createState() => _MyThemeState();
}

class _MyThemeState extends State<MyTheme> {
  bool isLight = false;

  @override
  void initState() {
    isLight = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Theme switch'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text(isLight ? 'Night' : 'Light'),
            onPressed: () {
              setState(() {
                isLight = !isLight;
              });
            },
          ),
        ),
        data: isLight ? widget.themes[0] : widget.themes[1]);
  }
}
