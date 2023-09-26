import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../../video_list/model/video_model.dart';

class VideoListDetail extends StatefulWidget {
  final VideoModel modle;

  VideoListDetail(this.modle);

  @override
  State<VideoListDetail> createState() => _VideoListDetailState();
}

class _VideoListDetailState extends State<VideoListDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.modle.playCount.toString()),
      ElevatedButton(
        onPressed: () {
          // 按下back键或button，都会回到 上一个界面调用的地方的await或者then
          widget.modle.playCount = widget.modle.playCount + 1;
          myPrint("修改playcount = ${widget.modle.playCount}");
          Navigator.pop(context, widget.modle);
        },
        child: const Text('返回'),
      ),
    ]);
  }
}
