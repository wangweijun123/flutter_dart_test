# flutter_dart_test

A new Flutter project.

播放器插件
https://github.com/hust-MC/flutter_player

测试视频地址:
https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



测试视频地址：

http://www.w3school.com.cn/i/movie.mp4
http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
http://vjs.zencdn.net/v/oceans.mp4
https://media.w3.org/2010/05/sintel/trailer.mp4

const 常量在编译期间确定


即刻时间：

单线程模型，你写得所有代码都在一个线程例执行， as 可以看到线程号

优先级处理，先处理微任务队列，然后再事件队列

微任务队列(手势)，  事件队列(io, net,)这样的任务会进入事件队列,Event looper

dart 同时支持jit(及时编译, hot reload, 还有js，pyth)， aot（运行前编译: 性能高）

dart : 大量 Widget 销毁重建的场景

dart 并发： isolate


dart 单线程模型，天然没有 资源竞争，状态同步问题
dart 自己的绘制skia引擎， reactive不是，是原生的绘制

jsbrige , h5 通信，提供给h5的系统能力， 也就是Hybrid

不必要的重绘

构造方法与 initState 函数在 State 的生命周期中都只会被调用一次，也大都用于完成一些初始化的工作。根据我们今天的学习，你能否举出例子，
比如哪些操作适合放在构造方法，哪些操作适合放在 initState，而哪些操作必须放在 initState


在构造函数中Widget还未生成，所以只能做一些参数传入的处理，initState中可以做初始化State的变量的操作。

源码或者 arr 嵌入到 android 

创建一个框架，把 Flutter 引擎、已编译的 Dart 代码和所有 Flutter 插件都放进去 这种方式你可以手动嵌入这个框架，
并在 Xcode 中更改现有的应用的构建设置。如果不想要求开发团队的每一位成员都在本地安装 
Flutter SDK 和 Cocoapods，这种方式比较适用。



单子widget容器， container

多子children 容器, column row( 方向，大小)
层叠 Widget 布局：Stack 与 Positioned


Stack(Positioned)摆放子widget，想对于父控件, 这两个是连用,Positioned 控件只能在 Stack 中使用

column的大小: 父widget 与 子widget， mainsize 三个来决定
Expanded 来按照比例 设置widget大小


自定义widget： 组装基本widget 与 自绘使用 CustomPainter

1.大部分都是非可视的容器，并不参与绘制；对于非透明的视图叠加，Flutter在绘制完毕后会做图层合并的



请问下，再混合开发的场景下,module类型的对于root Widget，我们必须使用MaterialApp或者CupertinoApp二选一么？如果不使用这两个基础的widgetApp，
除了不能享受封装好的Theme、封装好的Widget组件这些便利外，是否有无法实现的基础功能（比如在iOS中的右滑返回等等）？ 同时想问下目前国内很多App在
安卓上的表现都不是Material风格的，同时也不完全是Cupertino风格，所以在实际应用中，主流的做
法是使用 MaterialApp/CupertinoApp/完全自定义 这三种的哪一种呢？以及在开发过程中的是否有什么弊端呢？


作者回复: MaterialApp和CupertinoApp封装了一些基本的App功能，比如导航栈管理、屏幕管理，国际化，以及对应的脚手架等，自己实现没有必要也基本不可能。
样式就是一个配置而已，你可以自己定义不同平台的配置规则（具体参考夜间模式这一节）。另外他俩对Android/iOS的关键设计差异
（如导航栏样式、状态栏样式、弹窗样式等），在框架内就进行了区分实现，所以如果你不定制样式，也无需过多担心在iOS上长得太像Android。

Flutter其中一个游戏引擎flame ， 作者回复: 对，通过Canvas


跨组件之间传递数据:  


