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
  static const ICON_LIKE_SIZE = 70.0;
  _VideoViewState();

  Offset _globalPosition = Offset.zero;
  bool isLike = false;
  // ctrl + o 展示父类可以被复写的方法
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('duanxia build ...');
    return Scaffold(
        body: GestureDetector(
      onTap: onTapVideo,
      onDoubleTap: onDoubleTap,
      onDoubleTapDown: onDoubleTapDown,
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

        // Align 也是占满了整个屏幕(除去appbar), 注意可以写一个if语句，但是不能有闭包, 如果需要if else请使用三木运算符
        if (widget.player.state == FijkState.paused)
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                'packages/player/assets/play.png',
                width: 70,
                height: 70,
              )),

        if (isLike)
          Positioned(
              left: _globalPosition.dx - ICON_LIKE_SIZE / 2,
              top: _globalPosition.dy - ICON_LIKE_SIZE / 2,
              child: Image.asset(
                'packages/player/assets/like.png',
                width: ICON_LIKE_SIZE,
                height: ICON_LIKE_SIZE,
              )),
      ]),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    print('duanxia build dispose ...');
    widget.player.release();
  }

  void onTapVideo() {
    print('duanxia onTapVideo ...');

    if (widget.player.state == FijkState.paused) {
      widget.player.start();
    } else {
      widget.player.pause();
    }

    setState(() {});
  }

  // 双击与单击 互斥 onDoubleTap 与 onTap，也就是只会执行一个回调
  void onDoubleTap() {
    print('duanxia onDoubleTap ...');
  }

  void switchVideo() {
    widget.player.reset().then((value) {
      print('duanxia 重置后设置新的资源');
      widget.player
          .setDataSource('asset:///asset/video/video2.mp4', autoPlay: true);
    });
  }

  // down 事件
  void onDoubleTapDown(TapDownDetails details) {
    //  相对于屏幕坐标
    var globalPosition = details.globalPosition;

    _globalPosition = globalPosition;

    // 相对于父布局
    var localPosition = details.localPosition;
    print(
        'duanxia onDoubleTapDown globalPosition = $globalPosition, localPosition = $localPosition');

    isLike = true;
    setState(() {});
  }
}
