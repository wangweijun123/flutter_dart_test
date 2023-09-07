import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class VideoView extends StatefulWidget {
  final Player player;

  VideoView(this.player);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  _VideoViewState();

  // ctrl + o 展示父类可以被复写的方法
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: widget.player,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    widget.player.release();
  }
}
