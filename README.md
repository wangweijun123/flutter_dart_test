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










