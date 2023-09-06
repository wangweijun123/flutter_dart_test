import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/widget/t_image.dart';
import 'package:image_picker/image_picker.dart';

import '../gen/assets.gen.dart';
import '../log_util.dart';

class MinePage extends StatefulWidget {
  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const IMAGE_HEIGHT = 138.5;

  String _imagePath = Assets.image.defaultPhoto.path;

  void changeImagePath(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('我的主页'),
      // ),

      // Stack 默认包裹内容
      body: Stack(
        children: [
          GestureDetector(
            child: TImage(
              _imagePath,
              width: double.infinity,
              height: IMAGE_HEIGHT,
            ),
            onTap: () {
              // changeImagePath(Assets.image.girl.path);
              myPrint('选择相册');
              openImagetPicker();
            },
          ),
        ],
      ),
    );
  }

  Future<void> openImagetPicker() async {
    var xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    var path = xfile?.path;
    myPrint(path);
    if (path != null) {
      changeImagePath(path);
    }
  }
}
