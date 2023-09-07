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
    print('build onTapVideo ...');
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: GestureDetector(
          onTap: onTapVideo,
          child: Stack(children: [
            // 注意这个对事件的处理
            AbsorbPointer(
              absorbing: true,
              child: FijkView(
                player: widget.player,
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: FijkView(
                player: widget.player,
              ),
            ),

            // center 占满了整个屏幕(除去appbar)
            // Center(
            //     child: Image.asset(
            //   'packages/player/assets/play.png',
            //   width: 70,
            //   height: 70,
            // )),

            // Align 也是占满了整个屏幕(除去appbar)
            if (widget.player.state == FijkState.paused)
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'packages/player/assets/play.png',
                    width: 70,
                    height: 70,
                  )),
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    widget.player.release();
  }

  void onTapVideo() {
    print('onTapVideo ...');
    if (widget.player.state == FijkState.paused) {
      widget.player.start();
    } else {
      widget.player.pause();
    }

    setState(() {});
  }
}
