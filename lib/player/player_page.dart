import 'package:flutter/cupertino.dart';
import 'package:fultter_dart_sample/log_util.dart';

import 'package:player/player.dart';
import 'package:player/video_view.dart';

// import 'package:player/videoplayer/player.dart';
// import 'package:player/videoplayer/video_player_page.dart';

class PlayerPage extends StatefulWidget {
  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context)!.settings.arguments as String?;

    // const url = '/data/user/0/com.example.flutter_dart_test/cache/movie.mp4';
    url ??= 'asset:///asset/video/video1.mp4';

    var player = Player();
    // player.setCommonDataSource('https://www.w3schools.com/html/movie.mp4',
    //     autoPlay: true);

    // "asset:///assets/butterfly.mp4"
    // player.setCommonDataSource('asset:///asset/video/video1.mp4',
    //     autoPlay: true);
    myPrint('播放url = $url');
    // 本地视频
    player.setCommonDataSource(url, autoPlay: true);

    return VideoView(player);
  }
}
