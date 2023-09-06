import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/widget/t_image.dart';
import 'package:image_picker/image_picker.dart';

import '../gen/assets.gen.dart';
import '../log_util.dart';
import 'mine_page_controller.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  static const IMAGE_HEIGHT = 138.5;

  late MinePageController controller;

  @override
  Widget build(BuildContext context) {
    controller = MinePageController();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('我的主页'),
      // ),

      // Stack 默认包裹内容
      body: Stack(
        children: [
          GestureDetector(
            child: Obx(() => TImage(
                  controller.imagePath.value,
                  width: double.infinity,
                  height: IMAGE_HEIGHT,
                )),
            onTap: () {
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
      controller.imagePath.value = path;
    }
  }
}
