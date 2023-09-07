import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:player/player.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  // ctrl + o 展示父类可以被复写的方法
  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);

    Player().getPlatformVersion().then(
      (value) {
        myPrint('response version = $value');
      },
      onError: (e) {
        myPrint('onError = $e');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: player,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
