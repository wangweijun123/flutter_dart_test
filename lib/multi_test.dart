import 'dart:isolate';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:fultter_dart_sample/model/todo.dart';
import 'package:fultter_dart_sample/video_list/widget/video_list.dart';
import 'animation/test_animation.dart';
import 'animation/favorite_gesture/me/test_animation2.dart';
import 'bmi_calculator/screens/input_page.dart';
import 'camera/camera_page.dart';
import 'clima/screens/loading_screen.dart';
import 'easy_refresh_list/cdn/test_page_state.dart';
import 'easy_refresh_list/easy_refresh_list.dart';
import 'easy_refresh_list/sample_by_github/copy/example.dart';
import 'easy_refresh_list/sample_by_github/example.dart';
import 'jike/layout_test.dart';
import 'jike/list_view_youhua.dart';
import 'jike/listview_header.dart';
import 'jike/theme_switch.dart';
import 'listgridview/list_or_grid_test.dart';
import 'listview.dart';
import 'nested/nested_scroll_view_test3.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:align_positioned/align_positioned.dart';

import 'StatefulLifecycle.dart';
import 'mine/mine_page.dart';
import 'nested/nested_scroll_view_test.dart';
import 'nested/nested_scroll_view_test2.dart';
import 'obx/obx_test.dart';
import 'obx/set_state_test.dart';
import 'page_view/page_view_example.dart';
import 'player/player_page.dart';
import 'second_page.dart'; // 相对路径
import 'shopping_list_item.dart';
import 'todoey/main.dart';
import 'use_dio_file_download.dart';
import 'use_shared_preferences.dart';
import 'test_layout.dart';
import 'visible/main.dart';
import 'visible/me/test_visiable.dart';

// import 'package:matrix4_transform/matrix4_transform.dart';

const String TAG = "duanxia";

void main2() {
  // 应用的起点

  print("$TAG main ...");
  // runApp(MyApp());

  // 注意这里MaterialApp 带有路由的页面
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  bool toggle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    } else {
      return ElevatedButton(
        onPressed: () {},
        child: const Text('Toggle Two'),
      );
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => const SecondRoute(),
        settings: const RouteSettings(
          arguments: {'id': '123'},
        ),
      ),
    );

    print("返回结果 result = $result");
    // debugPrint
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView 相当于android ScrollView 垂直
        child: Column(children: [
          Container(
              width: 150, height: 30, child: Text(Strings.welcomeMessage)),
          ElevatedButton(
            child: const Text('主题theme切换测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyThemePage(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('布局测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayoutTest(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('任务列表'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAppDateProvider(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('天气app测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(
                    theme: ThemeData.dark(),
                    home: LoadingScreen(),
                  ),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('visiable 测试 me'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestVisiable(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('visiable 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(
                    theme: ThemeData.dark(),
                    home: StoryPage(),
                  ),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('bmi 计算器'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(
                    theme: ThemeData.dark().copyWith(
                      primaryColor: Color(0xFF0A0E21),
                      scaffoldBackgroundColor: Color(0xFF0A0E21),
                    ),
                    home: InputPage(),
                  ),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('pageView 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageViewExample(),
                ),
              );
            },
          ),

          //
          ElevatedButton(
            child: const Text('GetX 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OBXTest(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('set state 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetStateTest(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('拍照'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraApp(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('视频列表'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoList(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('fijk player 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayerPage(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('dio 测试下载'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FileDownloadPage()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('grid or list 测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GridLayoutTest(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('嵌套滑动测试'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NestedScrollViewExampleApp(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('嵌套滑动测试2'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NestedScrollViewExampleApp2(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('嵌套滑动测试3'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NestedScrollViewExampleApp3(),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('我的主页'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MinePage(),
                  settings: const RouteSettings(
                    arguments: {'id': '123'},
                  ),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('测试路由'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondRoute(),
                  settings: const RouteSettings(
                    arguments: {'id': '123'},
                  ),
                ),
              );
            },
          ),

          ElevatedButton(
            child: const Text('测试路由并返回结果'),
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
          ),

          _getToggleChild(),

          ElevatedButton(
            child: const Text('点击我控制第二个widget显示文本或者按钮'),
            onPressed: () {
              _toggle();
            },
          ),

          FadeTransition(
            opacity: curve,
            child: const FlutterLogo(
              size: 100,
            ),
          ),

          ElevatedButton(
            child: const Text('点击我开始动画'),
            onPressed: () {
              controller.forward();
            },
          ),

          ElevatedButton(
            child: const Text('点击我进入动画界面'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestAnimation()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('点击进入我的红心'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestAnimation2()),
              );
            },
          ),

          CustomButton("我是自动以button"),

          ElevatedButton(
            child: const Text('使用Isolate (执行更多的 CPU 密集型操作)'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IsolatePage()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('抽屉'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityUiPage()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('align postion test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MaterialApp(home: AlignPositionTest())),
              );
            },
          ),

          ElevatedButton(
            child: const Text('listview test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListviewPage(
                          todo: Todo('this is title', 'this is desc'),
                        )),
              );
            },
          ),

          ElevatedButton(
            child: const Text('listview 优化 test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListviewYouhuaTest()),
              );
            },
          ),

          //
          ElevatedButton(
            child: const Text('listview header test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListviewHeaderTest()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('dynamic listview test'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EasyRefreshListviewTest(),
                  ));
            },
          ),

          ElevatedButton(
            child: const Text('官方 dynamic listview test'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GithuEasyRefrshListview(),
                  ));
            },
          ),

          ElevatedButton(
            child: const Text('csdn dynamic listview test'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestPage(),
                  ));
            },
          ),

          ElevatedButton(
            child: const Text('shared prefenrece test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestSharedPreference()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('shop test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestShopping()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('layout test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestLayout()),
              );
            },
          ),

          ElevatedButton(
            child: const Text('测试stateful组件的生命周期'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TestStatefulLifecycle()),
              );
            },
          ),

          // ElevatedButton(
          //   child: const Text('测试stateful组件的生命周期'),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => VideoScreen(
          //               url:
          //                   'https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv')),
          //     );
          //   },
          // ),

          buildCircleConer(),
          buildCircleConer2(),
          Text("tttt"),
        ]),
      ),
    );
  }
}

Widget buildCircleConer() {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      image: const DecorationImage(
        image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        fit: BoxFit.cover,
      ),
      border: Border.all(
        width: 20,
      ),
      // radius 半径
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Widget buildCircleConer2() {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      image: const DecorationImage(
        image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        fit: BoxFit.cover,
      ),
      border: Border.all(width: 20, color: Colors.red),
      // radius 半径
      borderRadius: BorderRadius.circular(100),
    ),
  );
}

class ActivityUiPage extends StatefulWidget {
  @override
  State<ActivityUiPage> createState() => _ActivityUiPageState();
}

class _ActivityUiPageState extends State<ActivityUiPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellowAccent,
        appBar: AppBar(
          title: Text("my title"),
          actions: [
            IconButton(onPressed: null, icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: Container(
          color: Colors.red,
        ),
        drawer: Drawer(
          backgroundColor: Colors.amber,
          child: Text("Item 1"),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    myPrint('load data ...');
    loadData();
  }

  Widget getBody() {
    bool showLoadingDialog = widgets.isEmpty;
    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: getBody(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  // isolate 注意会增加内存的，少用，
  Future<void> loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    SendPort sendPort = await receivePort.first;
    myPrint('sendReceive ...');
    List msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      widgets = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(Uri.parse(dataURL));
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("$TAG MyApp=$hashCode MyApp build...");
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), // 这是数据
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(), // 这是ui, 在ui中观察这数据
      ),
    );
  }
}

/// 定义应用运行所需要的数据
/// ChangeNotifier 变化通知， 也就是数据变化通知widget
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // 初始化空列表, 使用[] 代表list
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
      print("从收藏列表删除   ${current.asLowerCase}");
    } else {
      favorites.add(current);
      print("添加收藏列表  ${current.asLowerCase}");
    }
    print("favorites length = ${favorites.length}");
    notifyListeners();
  }
}

// 由状态的导航栏(index), 集成StatefulWidget，
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 下划线 (_) 将该类设置为私有类
class _MyHomePageState extends State<MyHomePage> {
  //
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("$TAG _MyHomePageState= $hashCode 导航栏页面创建"); //  这里是同一个对象
    var appState = context.watch<MyAppState>(); // 这里是同一个对象
    print("导航栏页面创建 appState.hascode = ${appState.hashCode}");

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage(); // 注意这里是new出来的，所以一定产生不一样的对象
        break;
      case 1:
        // 注意这里是new出来的，所以一定产生不一样的对象, 所以之前的widget消失了，这是flutter的思想，状态变化，会导致widget重新创建
        page = FavitePage();
        break;
      default:
        throw UnimplementedError("no widget $selectedIndex");
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: constraints.maxWidth >= 600,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                print('selected: $value');
                // 此调用类似于之前使用的 notifyListeners() 方法 — 它会确保界面始终更新为最新状
                // 注意这里， _MyHomePageState.build() 重新调用
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page),
          ),
        ],
      ));
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("GeneratorPage = ${this.hashCode} like页面创建");

    var appState = context.watch<MyAppState>();
    print("like页面 appState.hascode = ${appState.hashCode}");
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("FavitePage = ${this.hashCode} 喜欢列表");

    var appState = context.watch<MyAppState>();
    print("like页面 appState.hascode = ${appState.hashCode}");
    var favorites = appState.favorites;

    return Text(favorites.toString());
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("MyHomePage build ... ");
//     // watch 订阅当前状态的更改
//     var appState = context.watch<MyAppState>();
//     var pair = appState.current;

//     IconData iconData;
//     if (appState.favorites.contains(pair)) {
//       print("收藏列表 存在 ${pair.asLowerCase}");
//       iconData =  Icons.favorite;
//     } else {
//       print("收藏列表 不存在  ${pair.asLowerCase}");
//       iconData = Icons.favorite_border;
//     }
//     // Icons.favorite;

//     return Scaffold(

//       // Column 仅占据其子项所需的水平空间
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,

//           children: [
//             Text('A random ASDFASDF idea:'),

//             BigCard(pair: pair),
//             SizedBox(height: 50),

//             Row(
//               // 制定主轴大小
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // ElevatedButton(onPressed: (){
//                 //   print("button pressed appState.current = ");
//                 //   // 改变数据是否会自动通知? 这样是OK的
//                 //   // appState.current = WordPair.random();
//                 //   // appState.notifyListeners();
//                 //   appState.toggleFavorite();
//                 //   print("like ...");
//                 // },
//                 // child: Text("like")),

//                 ElevatedButton.icon(icon: Icon(iconData), label:  Text("like"),
//                   onPressed: () {
//                     appState.toggleFavorite();

//                   },
//                 ),

//                 SizedBox(width: 50, height: 1),

//                 ElevatedButton(onPressed: (){
//                   print("button pressed appState.current = ");
//                   // 改变数据是否会自动通知? 这样是OK的
//                   // appState.current = WordPair.random();
//                   // appState.notifyListeners();
//                   appState.getNext();
//                   print("button ...");
//                 },
//                 child: Text("next"))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);
    // Flutter 会尽可能使用组合，而非继承。此处，padding 并不是 Text 的属性，而是一个 widge
    // Card 是 padding的父组件
    return Card(
      elevation: 10.0,
      // color: theme.colorScheme.primary,
      color: Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}

// 自定义 widget
class CustomButton extends StatelessWidget {
  final String label;

  const CustomButton(this.label, {super.key});

  @override
  Widget build(Object context) {
    return ElevatedButton(onPressed: null, child: Text(label));
  }
}

// 我们鼓励 Flutter 开发者使用 intl 包 进行国际化和本地化。https://pub-web.flutter-io.cn/packages/intl
class Strings {
  static String welcomeMessage = 'Welcome To Flutter';
}

class AlignPositionTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(title: const Text('AlignPositioned Example')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50, width: double.infinity),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.yellow,
                child: Stack(
                  children: [
                    AlignPositioned(
                      child: circle(Colors.yellow),
                      alignment: Alignment(0, 0),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.yellow),
                      alignment: Alignment(0.5, 0),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.yellow),
                      alignment: Alignment(-0.5, 0),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.yellow),
                      alignment: Alignment(0, 0.5),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.yellow),
                      alignment: Alignment(0, -0.5),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.red),
                      alignment: Alignment(-1, 0),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.blue),
                      alignment: Alignment(1, 0),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.green),
                      alignment: Alignment(0, -1),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.purple),
                      alignment: Alignment(0, 1),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.black38),
                      alignment: Alignment(-1, -1),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.black38),
                      alignment: Alignment(1, 1),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.black38),
                      alignment: Alignment(1, -1),
                      touch: Touch.middle,
                    ),
                    AlignPositioned(
                      child: circle(Colors.black38),
                      alignment: Alignment(-1, 1),
                      touch: Touch.middle,
                    )
                  ],
                ),
              ),
              //
              SizedBox(height: 50, width: double.infinity),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesInside())),
              //
              SizedBox(height: 50, width: double.infinity),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesOutside())),
              //
              SizedBox(height: 60),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithOffset())),
              SizedBox(height: 100),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithNamedAlignments())),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithDWidthAndDHeightInside())),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithDWidthAndDHeightOutside())),
              //
              SizedBox(height: 80),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Color(0x50000000), 60.0),
                    ),
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                    AlignPositioned(
                      rotateDegrees: 180,
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Color(0x50000000), 60.0),
                    ),
                    AlignPositioned(
                      rotateDegrees: 180,
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Stack(
                  children: <Widget>[
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      moveByContainerWidth: 1,
                      moveByContainerHeight: 1,
                      child: circle(Color(0x50000000), 60.0),
                    ),
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      moveByContainerWidth: 1,
                      moveByContainerHeight: 1,
                      child: circle(Colors.white, 5.0),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    for (double i = 0; i < 360 * 2; i += 5)
                      AlignPositioned(
                        alignment: Alignment.center,
                        rotateDegrees: i,
                        touch: Touch.inside,
                        moveByContainerWidth: 0.5 / 2 / 360 * i,
                        childWidthRatio: 0.5 / 2 / 360 * i,
                        childHeightRatio: 0.5 / 2 / 360 * i,
                        child: circle(Colors.white, 15.0),
                      )
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    for (double i = 0; i < 360; i += 45)
                      AlignPositioned(
                        alignment: Alignment.center,
                        rotateDegrees: i,
                        child: Container(
                            color: Colors.black, width: 60, height: 6),
                      ),
                    for (double i = 0; i < 360; i += 45)
                      AlignPositioned(
                        alignment: Alignment.center,
                        dx: 50,
                        dy: 60,
                        rotateDegrees: i,
                        child: Container(
                            color: Colors.black, width: 40, height: 8),
                      ),
                    for (double i = 0; i < 360; i += 5)
                      AlignPositioned(
                        alignment: Alignment.bottomLeft,
                        rotateDegrees: i,
                        child: Container(
                            color: Colors.black.withOpacity(i / 360 * .8),
                            width: 100,
                            height: 10),
                      )
                  ],
                ),
              ),
              //
              SizedBox(height: 120),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.purple,
                child: Stack(
                  children: <Widget>[
                    AlignPositioned(
                      alignment: Alignment.center,
                      rotateDegrees: 45,
                      child: Container(
                          color: Colors.yellow, width: 60, height: 20),
                    ),
                    AlignPositioned(
                      alignment: Alignment.center,
                      // matrix4Transform: Matrix4Transform().scale(2),
                      child: Container(
                          color: Colors.green.withOpacity(0.5),
                          width: 60,
                          height: 20),
                    ),
                    AlignPositioned(
                      alignment: Alignment.center,
                      rotateDegrees: 45,
                      // matrix4Transform: Matrix4Transform().scale(2),
                      child: Container(
                          color: Colors.red.withOpacity(0.5),
                          width: 60,
                          height: 20),
                    ),
                    AlignPositioned(
                      alignment: Alignment.center,
                      rotateDegrees: 45,
                      // matrix4Transform: Matrix4Transform().scale(2).rotateDegrees(90),
                      child: Container(
                          color: Colors.blue.withOpacity(0.5),
                          width: 60,
                          height: 20),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 0.5,
                  moveByContainerHeight: 0.25,
                  childWidth: 75,
                  wins: Wins.min,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 0.5,
                  moveByChildHeight: 0.5,
                  childWidth: 75,
                  wins: Wins.min,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 1.0,
                  minChildWidthRatio: 0.66,
                  maxChildWidthRatio: 0.33,
                  wins: Wins.min,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 1.0,
                  minChildWidthRatio: 0.66,
                  maxChildWidthRatio: 0.33,
                  wins: Wins.max,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 1.20,
                  moveByContainerHeight: 0.10,
                  childWidth: 190,
                  wins: Wins.max,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> circlesWithDWidthAndDHeightInside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.inside, 0, -1,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.inside, 0, -1,
        moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.green, Touch.inside, 0, -1,
        moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(circles(Colors.red, Touch.inside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.inside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(circles(Colors.green, Touch.inside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: -1.0));

    children1.addAll(circles(Colors.red, Touch.inside, 0, 1,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.inside, 0, 1,
        moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.green, Touch.inside, 0, 1,
        moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(circles(Colors.red, Touch.inside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.inside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(circles(Colors.green, Touch.inside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: -1.0));
    return children1;
  }

  List<Widget> circlesWithDWidthAndDHeightOutside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.outside, 0, -1,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.outside, 0, -1,
        moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.green, Touch.outside, 0, -1,
        moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(circles(Colors.red, Touch.outside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.outside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(circles(Colors.green, Touch.outside, 1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: -1.0));

    children1.addAll(circles(Colors.red, Touch.outside, 0, 1,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.outside, 0, 1,
        moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.green, Touch.outside, 0, 1,
        moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(circles(Colors.red, Touch.outside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.blue, Touch.outside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(circles(Colors.green, Touch.outside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: -1.0));
    return children1;
  }

  List<Widget> circlesInside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.inside, 0, -1));
    children1.addAll(circles(Colors.red, Touch.inside, -1, 0));
    children1.addAll(circles(Colors.red, Touch.inside, 0, 1));
    children1.addAll(circles(Colors.red, Touch.inside, 1, 0));
    children1.addAll(circles(Colors.blue, Touch.inside, -1, -1));
    children1.addAll(circles(Colors.blue, Touch.inside, -1, 1));
    children1.addAll(circles(Colors.blue, Touch.inside, 1, 1));
    children1.addAll(circles(Colors.blue, Touch.inside, 1, -1));
    return children1;
  }

  List<Widget> circlesOutside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.outside, 0, -1));
    children1.addAll(circles(Colors.red, Touch.outside, -1, 0));
    children1.addAll(circles(Colors.red, Touch.outside, 0, 1));
    children1.addAll(circles(Colors.red, Touch.outside, 1, 0));
    children1.addAll(circles(Colors.blue, Touch.outside, -1, -1));
    children1.addAll(circles(Colors.blue, Touch.outside, -1, 1));
    children1.addAll(circles(Colors.blue, Touch.outside, 1, 1));
    children1.addAll(circles(Colors.blue, Touch.outside, 1, -1));
    return children1;
  }

  List<Widget> circlesWithOffset() {
    var children2 = <Widget>[];
    children2
        .addAll(circles(Colors.purple, Touch.outside, 0, -1, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.purple, Touch.outside, -1, 0, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.purple, Touch.outside, 0, 1, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.purple, Touch.outside, 1, 0, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.green, Touch.inside, 0, -1, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.green, Touch.inside, -1, 0, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.green, Touch.inside, 0, 1, dx: -15, dy: 15));
    children2
        .addAll(circles(Colors.green, Touch.inside, 1, 0, dx: -15, dy: 15));

    return children2;
  }

  List<Widget> circles(
    Color color,
    Touch touch,
    int dirX,
    int dirY, {
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
  }) {
    return <Widget>[
      for (double i = 0.0; i <= 1.0; i += 0.1)
        alignPositionedCircle(i, color, dirX, dirY, touch, dx, dy,
            moveByChildWidth, moveByChildHeight),
    ];
  }

  List<Widget> circlesWithNamedAlignments() {
    return <Widget>[
      AlignPositioned(
          child: circle(Colors.orange),
          alignment: Alignment.center,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.orange),
          alignment: Alignment.center,
          touch: Touch.outside),

      //
      AlignPositioned(
          child: circle(Colors.green),
          alignment: Alignment.centerRight,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green),
          alignment: Alignment.bottomCenter,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green),
          alignment: Alignment.centerLeft,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green),
          alignment: Alignment.topCenter,
          touch: Touch.inside),
      //
      AlignPositioned(
          child: circle(Colors.blue),
          alignment: Alignment.topRight,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue),
          alignment: Alignment.bottomRight,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue),
          alignment: Alignment.topLeft,
          touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue),
          alignment: Alignment.bottomLeft,
          touch: Touch.inside),
      //
      AlignPositioned(
          child: circle(Colors.red),
          alignment: Alignment.centerRight,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red),
          alignment: Alignment.bottomCenter,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red),
          alignment: Alignment.centerLeft,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red),
          alignment: Alignment.topCenter,
          touch: Touch.outside),
      //
      AlignPositioned(
          child: circle(Colors.purple),
          alignment: Alignment.topRight,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple),
          alignment: Alignment.bottomRight,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple),
          alignment: Alignment.topLeft,
          touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple),
          alignment: Alignment.bottomLeft,
          touch: Touch.outside),
    ];
  }

  AlignPositioned alignPositionedCircle(
    double mult,
    Color color,
    int dirX,
    int dirY,
    Touch touch,
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
  ) {
    return AlignPositioned(
        child: circle(color),
        alignment: Alignment(mult * dirX, mult * dirY),
        touch: touch,
        dx: dx,
        dy: dy,
        moveByChildWidth: moveByChildWidth,
        moveByChildHeight: moveByChildHeight);
  }

  Container circle(Color color, [double diameter = 30.0]) {
    return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black),
          color: color,
          shape: BoxShape.circle,
        ));
  }
}
