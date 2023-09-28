import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../log_util.dart';

class CameraPageController extends GetxController {
  late List<CameraDescription> _cameras;
  CameraController? _cameraController;
  final _cameraControllerObs = Rx<CameraController?>(null);

  CameraController? get cameraController => _cameraControllerObs.value;

  void initCamera() async {
    myPrint('await init camera');
    _cameras =
        await availableCameras(); // 调用await后, initCamera函数会停止,会执行 initState()函数中的initCamera()的下一行
    myPrint('finished init camera');
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    _cameraController?.initialize().then((_) {
      myPrint('初始化相机完成');
      // 设置obs的值
      _cameraControllerObs.value = _cameraController;
      // setState(() {
      //   myPrint('刷新界面。。。 ');
      // });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  void dispose() {
    cameraController?.dispose();
  }

  void onCloseTap(BuildContext context) {
    Navigator.pop(context);
  }
}
