import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

// 下面的例子展示了异步加载数据并将之展示在 ListView 内
class _ThirdPageState extends State<ThirdPage> {
// {
//   "userId": 1,
//   "id": 2,
//   "title": "qui est esse",
//   "body": "est rerum ...."
// },
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    http.Response response = await http.get(dataURL);
    setState(() {
      var jsonBody = response.body;
      print("....jsonBody = $jsonBody");
      widgets = jsonDecode(jsonBody);
    });
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第三个界面'),
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }
}
