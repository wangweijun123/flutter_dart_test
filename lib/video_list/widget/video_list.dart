import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../controller/video_controller.dart';

class VideoList extends StatefulWidget {
  VideoController controller = VideoController();

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  void initState() {
    super.initState();

    myPrint('controller.hashCode = ${widget.controller.hashCode} ....');
    widget.controller.fetchVideoList().then((value) {
      setState(() {
        myPrint('refresh ....');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          widget.controller.dataList == null ? buildLaoding() : buildGridView(),
    );
  }

  Widget buildLaoding() {
    return Center(child: Text('加载中 ...'));
  }

  Widget buildGridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3), // crossAxisCount 每行几个item
        // item 总数
        itemCount: widget.controller.dataList!.length,
        itemBuilder: (context, index) {
          var item = widget.controller.dataList![index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Image.asset('images/pic$index.jpg'),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'packages/player/assets/play.png',
                      width: 10,
                      height: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.id,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ]),
          );
        });
  }
}
