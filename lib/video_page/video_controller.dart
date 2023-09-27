import 'dart:convert';

import 'video_model.dart';

class VideoController {
  // 本地mock数据，实际上是模拟网络数据
  static const _serverData = """{
    "title": "示例视频",
    "url": "https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
    "playCount": 88
}""";

  late VideoModel model;

  void init() {
    model = fetchVideoData();
  }

  // 缺点：
  // 1、需要针对json的每个字段创建get方法，一旦字段多了会非常繁琐
  // 2、需要保证map的字段和json的字段完全一致， 容易出错

  // 从服务端拉取视频Json字符串类型表示的视频数据
  VideoModel fetchVideoData() {
    return VideoModel.fromJson(jsonDecode(_serverData));
  }
}
