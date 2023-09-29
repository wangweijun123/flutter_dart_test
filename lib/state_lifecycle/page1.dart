import 'package:flutter/material.dart';
import './page2.dart';

class Page1 extends StatefulWidget {
  int startTime = 0;
  int endTime = 0;

  Page1({Key? key}) : super(key: key) {
    //页面初始化时记录启动时间
    startTime = DateTime.now().millisecondsSinceEpoch;
  }
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with WidgetsBindingObserver {
  //页面pop
  @override
  Future<bool> didPopRoute() => Future<bool>.value(false);
  //页面push
  @override
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

  //文本缩放系数变化
  @override
  void didChangeTextScaleFactor() {}
  //系统亮度变化
  @override
  void didChangePlatformBrightness() {}
  //本地化语言变化
  @override
  void didChangeLocales(List<Locale>? locales) {}
  //App生命周期变化
  //监听App生命周期回调(从前台切换到后台state inactive -> hidden -> paused)
  // 从后台监听到前台 hidden -> inactive ->  resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("page1 xx didChangeAppLifecycleState --->  $state");
    if (state == AppLifecycleState.resumed) {
      //do sth
    }
  }

  //内存警告回调
  @override
  void didHaveMemoryPressure() {}
  //Accessibility相关特性回调
  @override
  void didChangeAccessibilityFeatures() {}
  // 系统窗口相关改变回调，如旋转, 这是这个 WidgetsBindingObserver中回调
  @override
  void didChangeMetrics() {
    Size physicalSize = View.of(context).physicalSize;
    print(
        "page1 WidgetsBindingObserver didChangeMetrics......physicalSize = $physicalSize");
  }

  //当Widget第一次插入到Widget树时会被调用。对于每一个State对象，Flutter只会调用该回调一次
  @override
  void initState() {
    super.initState();
    print("page1 initState......");
    WidgetsBinding.instance.addObserver(this); //注册监听器

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 它会在当前 Frame 绘制完成后进行进行回调，并且只会回调一次，如果要再次监听则需要再设置一次。
      print("page1 单次Frame绘制回调"); //只回调一次
      widget.endTime = DateTime.now().millisecondsSinceEpoch;
      int timeSpend = widget.endTime - widget.startTime;
      print("Page render time:${timeSpend} ms");
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      // 这个函数会在每次绘制 Frame 结束后进行回调，可以用做 FPS 监测。WidgetsBinding.instance.addPersistentFrameCallback((_){ print("实时Frame绘制回调");//每帧都回调});
      print("page1 实时Frame绘制回调"); //每帧都回调
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("page1 setState......");
  }

  /*
  *初始化时，在initState之后立刻调用
  *当State的依赖关系发生变化时(语言，主题)，会触发此接口被调用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("page1 didChangeDependencies......");
  }

  //绘制界面
  @override
  Widget build(BuildContext context) {
    print("page1 build......");
    return Scaffold(
      appBar: AppBar(title: Text("Lifecycle demo")),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("打开/关闭新页面查看状态变化"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Parent()),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
  }

  //状态改变的时候会调用该方法,比如父类调用了setState
  @override
  void didUpdateWidget(Page1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("page1 didUpdateWidget......");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print('page1 deactivate......');
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print('page1 dispose......');
    WidgetsBinding.instance.removeObserver(this); //移除监听器
  }
}
