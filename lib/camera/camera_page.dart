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
        )
      ],
    );
  }
}
