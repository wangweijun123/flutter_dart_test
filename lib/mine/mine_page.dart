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
      body: SafeArea(
        child: Stack(
          children: [
            // 背景墙
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

            Padding(
              padding: const EdgeInsets.only(top: IMAGE_HEIGHT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 左边距直接使用
                      SizedBox(
                        width: 100,
                      ),

                      Column(
                        children: [
                          Text("获赞"),
                          Text('23万'),
                        ],
                      ),
                      Column(
                        children: [
                          Text("关注"),
                          Text('85334'),
                        ],
                      ),
                      Column(
                        children: [
                          Text("粉丝"),
                          Text('23889'),
                        ],
                      ),
                    ],
                  ),

                  // 姓名
                  Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                      child: const Text('王伟军')),

                  // id
                  Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                      child: const Text('id: 123456789')),

                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      const Text('点击添加介绍, 让大家认识你...'),
                      const SizedBox(
                        width: 15,
                      ),
                      TImage(
                        Assets.image.edit.path,
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),

                  Container(
                      // todo Container 圆角有问题
                      // decoration: BoxDecoration(
                      //   color: const Color(0xff7c94b6),
                      //   borderRadius: BorderRadius.circular(12),
                      // ),

                      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      alignment: Alignment.center,
                      color: Colors.red,
                      width: double.infinity,
                      height: 40,
                      child: Text('+ 关注')),
                ],
              ),
            ),

            buildCircleConer2()
          ],
        ),
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

  Widget buildCircleConer2() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, IMAGE_HEIGHT - 30, 0, 0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          fit: BoxFit.cover,
        ),
        border: Border.all(width: 4, color: Colors.white),
        // radius 半径
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
