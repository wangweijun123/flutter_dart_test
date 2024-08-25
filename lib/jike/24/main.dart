import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JIkeNetwork(title: 'Flutter Demo Home Page'),
    );
  }
}

class JIkeNetwork extends StatefulWidget {
  JIkeNetwork({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JIkeNetworkState createState() => _JIkeNetworkState();
}

class _JIkeNetworkState extends State<JIkeNetwork> {
  httpClientDemo() async {
    try {
      var httpClient = HttpClient();
      httpClient.idleTimeout = Duration(seconds: 5);
      var uri = Uri.parse("https://flutter.dev");
      var request = await httpClient.getUrl(uri);
      request.headers.add("user-agent", "Custom-UA");
      var response = await request.close();

      print('Respone code: ${response.statusCode}');
      print(await response.transform(utf8.decoder).join());
    } catch (e) {
      print('Error:$e');
    }
  }

  httpDemo() async {
    try {
      var client = http.Client();
      var uri = Uri.parse("https://flutter.dev");
      http.Response response =
          await client.get(uri, headers: {"user-agent": "Custom-UA"});
      print('Respone code: ${response.statusCode}');
      print(response.body);
    } catch (e) {
      print('Error:$e');
    }
  }

  nodeJsMockBackendDemo() async {
    try {
      Dio dio = Dio(); // 192.168.0.32
      // var url = "https://jsonplaceholder.typicode.com/posts/1/comments";
      // 就用id来访问
      var url = "http://192.168.0.32:3000/getHomePageContent";
      // var url = "http://10.0.2.2:3000/getHomePageContent";
      // var url = "http://127.0.0.1:3000/getHomePageContent";
      print('request url :$url');
      var response = await dio.post(url,
          options: Options(headers: {"user-agent": "Custom-UA"}));
      var result = response.data.toString();
      print('result = $result');
    } catch (e) {
      print('Error:$e');
    }
  }

  dioDemo() async {
    try {
      Dio dio = Dio();
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioParallDemo() async {
    try {
      Dio dio = new Dio();
      // 并发两个request后 刷新数据
      List<Response> responseX = await Future.wait([
        dio.get("https://flutter.dev"),
        dio.get("https://pub.dev/packages/dio")
      ]);

      //打印请求1响应结果
      print("Response1: ${responseX[0].toString()}");
      //打印请求2响应结果
      print("Response2: ${responseX[1].toString()}");
    } catch (e) {
      print('Error:$e');
    }
  }

  dioInterceptorReject() async {
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // handler.
      handler.reject(DioException(message: "拦截这个请求", requestOptions: options));
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCache() async {
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        handler.resolve(Response(requestOptions: options, data: "返回缓存数据"));
        // return dio.resolve("返回缓存数据");
      },
    ));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCustomHeader() async {
    print('dioIntercepterCustomHeader ....');
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) {
      options.headers["user-agent"] = "Custom-UA";
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  String jsonString = '''
    {
      "id":"123",
      "name":"张三",
      "score" : 95,
      "teacher": 
         {
           "name": "李四",
           "age" : 40
         }
    }
    ''';

  static Student parseStudent(String content) {
    final jsonResponse = json.decode(content);
    Student student = Student.fromJson(jsonResponse);
    return student;
  }

  Future<Student> loadStudent() {
    //  json解析 属于cpu密集型吗？？？， 需要在isolate中进行解析
    return compute(parseStudent, jsonString);
  }

  jsonParseDemo() {
    loadStudent().then((s) {
      String content = '''
        name: ${s.name}
        score:${s.score}
        teacher:${s.teacher.name}
        ''';
      print(content);
    });
  }

  /// 请使用 dio 实现一个自定义拦截器，拦截器内检查 header 中的 token：如果没有 token，需要暂停本次请求，
  /// 同时访问"http://xxxx.com/token"，在获取新 token 后继续本次请求
  dioIntercepLogin() {
    Dio dio = Dio();
    // dio.interceptors.add(InterceptorsWrapper(
    //     onRequest: (RequestOptions options,
    //         RequestInterceptorHandler handler,) async {
    //       if (options.headers['token'] == null) {
    //         print("no token，request token firstly...");
    //         //lock the dio.
    //         dio.lock();
    //         return new Dio().get("http://xxxx.com/token").then((d) {
    //           options.headers["token"] = d.data['token'];
    //           print("request token succeed, value: " + d.data['token']);
    //           print(
    //               'continue to perform request：path:${options.path}，baseURL:${options.path}');
    //           return options;
    //         }).whenComplete(() => dio.unlock()); // unlock the dio
    //       }
    //       return options;
    //     }
    // ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: Text('HttpClient demo'),
              onPressed: () => httpClientDemo(),
            ),
            TextButton(
              child: Text('http demo'),
              onPressed: () => httpDemo(),
            ),
            TextButton(
              child: Text('Dio demo'),
              onPressed: () => dioDemo(),
            ),
            TextButton(
              child: Text('node js  demo'),
              onPressed: () => nodeJsMockBackendDemo(),
            ),
            buildCircleConer2(),
            TextButton(
              child: Text('Dio 并发demo'),
              onPressed: () => dioParallDemo(),
            ),
            TextButton(
              child: Text('Dio 拦截'),
              onPressed: () => dioInterceptorReject(),
            ),
            TextButton(
              child: Text('Dio 缓存'),
              onPressed: () => dioIntercepterCache(),
            ),
            TextButton(
              child: Text('Dio 自定义header'),
              onPressed: () => dioIntercepterCustomHeader(),
            ),
            TextButton(
              child: Text('JSON解析demo'),
              onPressed: () => jsonParseDemo(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Student {
  String id;
  String name;
  int score;
  Teacher teacher;

  Student(
      {required this.id,
      required this.name,
      required this.score,
      required this.teacher});

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score'],
        teacher: Teacher.fromJson(parsedJson['teacher']));
  }
}

//
// 圆角头像
Widget buildCircleConer2() {
  // const String img =
  //     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';

  const String img = 'http://192.168.0.32:3000/images/banner/1.jpeg';
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 138.5 - 30, 0, 0),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      image: const DecorationImage(
        image: NetworkImage(img),
        fit: BoxFit.cover,
      ),
      border: Border.all(width: 4, color: Colors.white),
      // radius 半径
      borderRadius: BorderRadius.circular(50),
    ),
  );
}

class Teacher {
  String name;
  int age;

  Teacher({required this.name, required this.age});

  factory Teacher.fromJson(Map<String, dynamic> parsedJson) {
    return Teacher(name: parsedJson['name'], age: parsedJson['age']);
  }
}
