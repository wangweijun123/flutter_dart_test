import 'package:flutter/material.dart';
import 'item_detail.dart';
import 'model/todo.dart';

class ListviewPage extends StatelessWidget {
  // 数据通过构造函数传进来
  final Todo todo;

  const ListviewPage({super.key, required this.todo});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("列表页面接收到 ${todo.toString()}");
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Todo> _data = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      _data.add(Todo('this is title= $i', 'this is desc= $i'));
    }
  }

  Widget getRow(int i) {
    Todo item = _data[i];
    return GestureDetector(
      onTap: () {
        print('click ...');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailScreen(),
              // Pass the arguments as part of the RouteSettings. The
              // DetailScreen reads the arguments from these settings.
              settings: RouteSettings(
                arguments: item,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(item.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List view test'),
      ),
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: ((context, index) {
            return getRow(index);
          })),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(GestureDetector(
          onTap: () {
            print("click Row $i");
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Row $i'),
          )));
    }
    return widgets;
  }
}
