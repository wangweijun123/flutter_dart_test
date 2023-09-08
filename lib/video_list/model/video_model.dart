class VideoModel {
  String id = '';
  String url = '';
  int playCount = 0;

  VideoModel(this.id, this.url, this.playCount);

  // const jsonString =
  //       '{"id": "foo", "url": "http:www.baidu.com", "playCount": 100}';

  factory VideoModel.fromJson(Map<String, dynamic> map) =>
      VideoModel(map['id'], map['url'], map['playCount']);
}
