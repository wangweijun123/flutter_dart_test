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

dart 同时支持 jit(及时编译, hot reload, 还有js，pyth)， aot（运行前编译: 性能高）

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

flutter 切换主题样式, 视觉配置管理机制, 使用的时候一定从样式里面来取,
如果有一个页面单独设置某一个copy出来，修改你关系的就行

todo: 切换主题 dark 模式

资源文件的声明， pubspec.yaml, 注意有两种方式，挨个指定资源路径，文件目录批量指定，注意不能递归
flutter:
assets:
- assets/background.jpg   #挨个指定资源路径
- assets/loading.gif  #挨个指定资源路径
- assets/result.json  #挨个指定资源路径
- assets/icons/    #子目录批量指定
- assets/ #根目录也是可以批量指定的

图片适配： 保持与ios一致 1.0X, 2.0X, 3.0X, 更换图标icon，肯定是在原始android与ios 项目中修改

像素密度相近

对于像素密度3.0x的会找到2.0x的图片，对于2.0x的像素密度，1.0会自动压缩处理


老师，您好。有 2 个疑问，希望您能解答。
1. Flutter 中加载图片，会对图片的尺寸做优化吗？例如同一张 50x50 的图片，显示在两个不同尺寸的 Image 上，例如 20x20 和 40x40 的 Image，它们在内存中是一份还是两份数据？ 然后在内存中占用的内存尺寸，是如何计算的？是按照原图的尺寸和它所存放的位置来计算的，还是依赖加载 Widget 的尺寸？
2. 如果是网络图片，又是如何处理的？会和 Android 的 Glide 之类的图片库一样，对其进行采样率的压缩吗？
   你可以自己试验一下，用Dart DevTools中的Memory工具

同一张图片比如网络图片，显示在两个地方,原始图片沾一份，两份渲染图片，如何证明 dev tools --> 查看内存

1.0x、2.0x、3.0x  是对于像素密度

对于包，我们通常是指定版本区间，而很少直接指定特定版本，因为包升级变化很频繁，如果有其他的包直接或间接依赖这个包的其他版本时，就会经常发生冲突。
而对于运行环境，如果是团队多人协作的工程，建议将 Dart 与 Flutter 的 SDK 环境写死，统一团队的开发环境，避免因为跨 SDK 版本出现的 API 差异进而导致工程问题。


pubspec.lock: 确定的依赖版本，因为依赖配置的是范围,  pubspec.lock 文件也一并提交到代码版本管理

触摸事件从最内存组件开始，沿着组件数向根节点分发

手势竞技场: 确定用户的行为，只会有一个回调

手势: 父组件 与 子 组件, 默认肯定是只有子 组件， 但是可以改父子都可以收到 MultipleTapGestureRecognizer

事件传递问题： 子组件不处理，抛给父组件

Lisenten 原始的手势事件，   GestureDetector 


组件(页面也行呀)共享数据, event bus

EventBus ：通过事件总线，全局，方便，但要记住事件名称，全局容易冲突，组件消除要清理事件。

在敲代码时候的有两点需要注意的地方。

1、在传入 runApp 里面的 widget 里面做路由跳转的时候所使用的的 BuildContext 不能是 App 的，必须得是 widget 的，否则会报 
Navigator operation requested with a context that does not include a Navigator 这样子的错。

2、使用命名路由或者注册表的方式，最好是在传入 runApp 里面的 widget 的MaterialApp 里面做 routes 的配置，为的是 APP 
一启动的时候就注册上，否则可能会存在要使用命名，可是还没注册的情况，就会报 Could not find a generator for route RouteSettings("second_page", null) in the _WidgetsAppState 这样的错误。


通过 Hero，我们可以在两个页面的共享元素之间，做出流畅的页面切换效果。



，只重绘需要做动画的组件即可

event looper

dart 单线程模型为什么不会导致卡顿

每个 Isolate 都有自己的 Event Loop 与 Queue


作者回复: 我们所说的单线程指的是主Isolate。而GPU绘制指令有单独的线程执行，跟主Isolate无关。事实上Flutter提供了4种task runner，有独立的线程去运行专属的任务：
1.Platform Task Runner：处理来自平台（Android/iOS）的消息
2.UI Task Runner：执行渲染逻辑、处理native plugin的消息、timer、microtask、异步I/O操作处理等
3.GPU Task Runner：执行GPU指令
4.IO Task Runner：执行I/O任务
除此之外，操作系统本身也提供了大量异步并发机制，可以利用多线程去执行任务（比如socket），我们在主Isolate中无需关心（如果真想主动创建并发任务也可以）


方法通道是非线程安全的。这意味着原生代码与 Flutter 之间所有接口调用必须发生在主线程。Flutter 是单线程模型，因此自然可以确保方法调用请求是发生在主线程（Isolate）的；
而原生代码在处理方法调用请求时，如果涉及到异步或非主线程切换，需要确保回调过程是在原生系统的 UI 线程（也就是 Android 和 iOS 的主线程）
中执行的，否则应用可能会出现奇怪的 Bug，甚至是 Crash。


方法通道Method channel 逻辑复用，dart 调用 native, Flutter 提供了一个平台视图（Platform View）的概念, flutter 复用native view



CocoaPods 管理flutter, iOSDemo 根目录下创建一个只有基本信息的 Podfile 文件：
即 Android 使用 aar、iOS 使用 pod, 混编方案会将 Flutter 模块打包成 aar 和 pod，

包体积最少会增加多少呢？
: iOS 15MB左右，安卓5MB左右
三端工程分别管理，一个工程一个仓库

原生采用单容器单页面（一个 ViewController/Activity 对应一个原生页面）
、Flutter 采用单容器(FlutterView)多页面（一个 ViewController/Activity 对应多个 Flutter 页面）的机制。Flutter 在原生的导航栈之上又自建了一套 Flutter 导航栈,
可以理解单activity 多fragment的例子



flutter page --> 跳转 native page 借助method channel 通道,  



关闭flutter页面, 

老师我想请教一下，原生界面和flutter界面互相跳转的时候出现屏幕一闪的现象，有解决方案吗

Debug环境吧？Release环境加载会快很多，另外可以考虑提前把引擎初始化
把flutter容器做成单例，提前初始化好, 将Flutter容器做成一个单例

状态管理(管理数据，多个页面共享数据):  源自 Flutter 官方的状态管理框架 Provider 则相对简单得多, 

所有app共享消息推送服务(本质是长连接)，只要有一个app没死掉，其他app就可以接受到属于自己的消息

flutter 只是一个ui框架，对于推送与系统能力相关的，只能native来做, native收到后(注意flutter引擎还没有起来)通过


国际化: 多语言,还有什么? 还有图片，还有显示文本的差异 


老师，图片资源的国际化适配，可以在assets下创建不同语言的目录，然后利用i18n的翻译功能，在values下对应的arb文件中分别添加不同的图片路径，
使用的时候使用S.of(context).images这种方式，完成国际化的图片资源使用。不知道这么做是不是合适

图片国际化就是去找图片路径

适配： 适配屏幕旋转， 适配平板电脑

Debug 模式对应 Dart 的 JIT 模式: flutter run --debug
Release 模式对应 Dart 的 AOT 模式 flutter run --release
Profile 模式，基本与 Release 模式一致 lutter run --profile
该模式用于分析真实设备实际运行性能。

if(kReleaseMode){
//Do sth for release
} else {
//Do sth for debug
}

//打包开发环境应用程序
flutter build apk -t lib/main_dev.dart
flutter build ios -t lib/main_dev.dart

//打包生产环境应用程序
flutter build apk -t lib/main.dart
flutter build ios -t lib/main.dart

hot reload实现原理: Jit 肯定是动态下了代码(动态编译修改的东西,增量编译)， 执行代码


AOT 编译成可执行的二进制代码


介绍几个不支持热重载的典型场景：

代码出现编译错误；
Widget 状态无法兼容；
全局变量和静态属性的更改；
main 方法里的更改；
initState 方法里的更改；
枚举和泛类型更改。


如何检测并优化 app 整体性能:

在 Flutter 中，性能问题可以分为 GPU 线程问题和 UI 线程（CPU）问题两类

利用 Flutter 提供的各类分析工具来定位问题了。

线上出现问题(本地没有问题，因为没有用户的环境，所以需要...) .... 异常捕获，如何上报

不强制try catch，如果某一个任务异常了，只是这一个任务失败了，用户还可以操作其他任务，与js一样

与 Java 不同的是，Dart 程序不强制要求我们必须处理异常
这是因为，Dart 采用事件循环的机制来运行任务，所以各个任务的运行状态是互相独立的。也就是说，即便某个任务出现了
异常我们没有捕获它，Dart 程序也不会退出，只会导致当前任务后续的代码不会被执行，用户仍可以继续使用其他功能

Dart 异常，根据来源又可以细分为 App 异常和 Framework 异常。Flutter 为这两种异常提供了不同的捕获方式，接下来我们就一起看看吧

Bugly 有能力收集 c++ 层的代码 (符号表)


app 质量的三个指标：

页面异常率；
页面帧率；fps = 推荐60, 
页面加载时长。

什么是 60Hz，而不是更高或更低的值呢？这是因为显示过程，是由 VSync 信号周期性驱动的，而 VSync 信号的周期就是每秒 60 次，这也是 FPS 的上限。
FPS 低于 60Hz 时就会出现掉帧现象，而如果低于 45Hz 则会有比较严重的卡顿现象。 

用户与app没有交互，是不会发出信号的, 

FPS 计算公式最终确定为：FPS=60* 实际渲染的帧数 / 本来应该在这个时间内渲染完成的帧数。


如何监控:  

组件化又叫模块化

勿畏难，勿轻略

https://gmtc.infoq.cn/2019/shenzhen/presentation/2042

Widget 和 Element 是一一对应的，但 RenderObject 不是

Widget  element  renderObject

Widget 视图配置
flutter 接管了 应用渲染层, 底层能力需要native

methodchannel 解决flutter 无法实现系统能力的办法
PlatformView 能将原生视图切入到 flutter widget树中渲染


MainActivity configureFlutterEngine ....
flutter_xxxx  flutter main

flutter以一个module的形式嵌入原生工程
ios 使用pod， android 使用 aar


子渲染引擎


不是一个空安全的库的解决 方案:
flutter run --no-sound-null-safety


https://github.com/hust-MC/flutter_player.git


相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量
相信自己，每天都保持正能量













