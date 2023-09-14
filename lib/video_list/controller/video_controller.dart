import 'dart:convert';

import '../../log_util.dart';
import '../model/person_model.dart';
import '../model/video_model.dart';

import 'package:json_annotation/json_annotation.dart';

class VideoController {
  List<VideoModel>? dataList;
  // 模拟网络
  Future<void> fetchVideoList() async {
    myPrint('$hashCode  ,Awaiting get video list...');
    var list = await _fetchVideoList();
    dataList = list;
    myPrint('result finished:');
  }

  static const jsonString = '{"id": "foo", "url": 1, "playCount": 1}';
  static const jsonArray = '''
    [
      {"id": "foo", "url": "xx", "playCount": 100},
     {"id": "eex", "url": "ddddd", "playCount": 125}
     ]
  ''';

  /// String id = '';
  //   String url = '';
  //   int playCount = 0;

  Future<List<VideoModel>> _fetchVideoList() {
    // testPerson();

    // Imagine that this function is more complex and slow.
    return Future.delayed(const Duration(seconds: 1), () {
      myPrint(' 耗时函数体 ... ');

      List<VideoModel> result = [];
      final List<dynamic> dataList = jsonDecode(jsonArray);
      for (dynamic jsonItem in dataList) {
        VideoModel item = VideoModel.fromJson(jsonItem);
        result.add(item);
      }
      return result;
    });
  }

  Future<List<VideoModel>> _fetchVideoList2() {
    // Imagine that this function is more complex and slow.
    return Future.delayed(const Duration(seconds: 1), () {
      return List.generate(30, (index) => VideoModel('$index', 'xx', 1));
    });
  }

  void testPerson() {
    // var date = DateTime.parse('1969-07-20 20:18:04Z');
    // final String firstName, lastName;

    /// The generated code below handles if the corresponding JSON value doesn't
    /// exist or is empty.
    // final DateTime? dateOfBirth;
    const source =
        '{"firstName": "wang", "lastName": "weijun", "dateOfBirth": "1969-07-20 20:18:04Z"}';
    var person = Person.fromJson(jsonDecode(source));
    myPrint(person.toString());

    var json = person.toJson();
    myPrint(json.toString());
  }
}
