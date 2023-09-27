import 'package:flutter/material.dart';
import '../player/player_page.dart';
import 'video_controller.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

class VideoListMooc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoListMoocState();
}

class _VideoListMoocState extends State<VideoListMooc> {
  late VideoController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoController();
    _controller.init();
    print('MOOC- title: ${_controller.model.title}');
    print('MOOC- url: ${_controller.model.url}');
    print('MOOC- playCount: ${_controller.model.playCount}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 15,
            itemBuilder: (context, index) {
              // 实际羡慕中， 通过dateList[index]取出url
              return GestureDetector(
                  child: AbsorbPointer(
                      absorbing: true,
                      child: VideoView(Player()
                        ..setCommonDataSource(_controller.model.url,
                            type: SourceType.net, autoPlay: true))),
                  onTap: () {
                    jump();
                  });
            }));
  }

  void jump() async {
    // await router.push(name: MCRouter.playerPage, arguments: _controller.model.url)
    // 或者使用构造函数传入参数
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerPage(_controller.model.url),
        // settings: RouteSettings(arguments: _controller.model.url),
      ),
    );
  }
}
