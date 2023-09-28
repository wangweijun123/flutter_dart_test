import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../log_util.dart';

class CameraPageController extends GetxController {
  late List<CameraDescription> _cameras;
  CameraController? _cameraController;
  final _cameraControllerObs = Rx<CameraController?>(null);

  CameraController? get cameraController => _cameraControllerObs.value;

  int cameraIndex = 0;

  var _flash = false.obs;

  bool get flash => _flash.value;

  set flash(bool enable) => _flash.value = enable;

  var _recording = false.obs;

  bool get recording => _recording.value;
  set recording(bool recording) => _recording.value = recording;

  void initCamera() async {
    myPrint('await init camera');
    // 调用await后, initCamera函数会停止,会执行 initState()函数中的initCamera()的下一行
    availableCameras().then((value) {
      _cameras = value;
      _initCameraController();
    });
    myPrint('finished init camera, _cameras.size = ${_cameras.length} ');
  }

  _initCameraController() {
    _cameraController =
        CameraController(_cameras[cameraIndex], ResolutionPreset.max);
    _cameraController?.initialize().then((_) {
      myPrint('初始化相机完成cameraIndex = $cameraIndex, 设置obs的值刷新');
      // 设置obs的值, ui 监听cameraController，刷新界面。。。
      _cameraControllerObs.value = _cameraController;
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

  onSwitchCamera() {
    myPrint('切换相机');
    if (_cameras != null && _cameras.length > 1) {
      cameraIndex = (cameraIndex == 0 ? 1 : 0);
      _initCameraController();
    }
  }

  // 录制视频
  takePhotoAndUpload() async {
    myPrint('录制视频....recording = $recording');
    if (recording) {
      var xFile = await _cameraController?.stopVideoRecording();
      myPrint("path = ${xFile?.path}");
      _cameraController?.pausePreview();
    } else {
      _cameraController?.startVideoRecording();
    }
    recording = !recording;
  }

  onSwitchFlash() {
    myPrint('切换闪光灯 ....');
    _cameraController?.setFlashMode(flash ? FlashMode.off : FlashMode.always);
    flash = !flash;
  }
}
