import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:fultter_dart_sample/widget/t_image.dart';

import '../gen/assets.gen.dart';
import 'camera_page_controller.dart';
import 'package:get/get.dart';

// Future<void> main() async {
//   runApp(const CameraApp());
// }

/// CameraApp is the Main Application.
class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraPageController cameraPageController;

  @override
  void initState() {
    super.initState();
    myPrint('before init camera'); //
    cameraPageController = CameraPageController();
    cameraPageController.initCamera();
    myPrint('after init camera');
  }

  @override
  void dispose() {
    cameraPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myPrint(
        'build ... cameraPageController.cameraController = ${cameraPageController.cameraController}');
    return Stack(
      children: [
        // 相机视频预览区域
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Obx(() {
            return cameraPageController.cameraController == null
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text('初始化相机中 ....'),
                    ),
                  )
                : CameraPreview(cameraPageController.cameraController!);
          }),
        ),

        // close

        GestureDetector(
          onTap: () {
            cameraPageController.onCloseTap(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 60.0),
            child: TImage(
              Assets.image.close.path,
              width: 28,
              height: 28,
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, right: 30.0),
            child: Column(
              children: [
                _buildIcon(Assets.image.rotate.path, '翻转',
                    () => cameraPageController.onSwitchCamera()),
                SizedBox(height: 16),
                _buildIcon(
                    Assets.image.clock.path,
                    '倒计时',
                    () => Future.delayed(Duration(seconds: 3),
                        () => cameraPageController.takePhotoAndUpload())),
                SizedBox(height: 16),
                Obx(() => _buildIcon(
                    cameraPageController.flash
                        ? Assets.image.flashOn.path
                        : Assets.image.flashOff.path,
                    '闪光灯',
                    () => cameraPageController.onSwitchFlash())),
              ],
            ),
          ),
        ),

        // 拍照
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: GestureDetector(
              onTap: () => cameraPageController.takePhotoAndUpload(),
              child: Obx(() => Container(
                    height: 80,
                    width: 80,
                    // 装饰
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: cameraPageController.recording
                          ? Colors.grey
                          : Colors.redAccent,
                      border: Border.all(width: 4, color: Colors.white),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 22),
                      child: TImage(Assets.image.flashOn.path,
                          height: 33, width: 33),
                    ),
                    // child: TImage(Assets.image.flashOn.path, height: 33, width: 33),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建控制Button，图片+文本，垂直结构
  Widget _buildIcon(String iconPath, String title, GestureTapCallback? onTap) {
    myPrint("build title = $title");
    return GestureDetector(
        onTap: onTap,
        child: Column(children: [
          TImage(iconPath, width: 25, height: 25),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  decoration: TextDecoration.none))
        ]));
  }
}
