import 'package:flutter/cupertino.dart';
import 'package:player/videoplayer/player.dart';
import 'package:player/videoplayer/video_player_page.dart';

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
    var player = Player();
    player.setCommonDataSource('https://www.w3schools.com/html/movie.mp4',
        autoPlay: true);
    return VideoView(player);
  }
}
