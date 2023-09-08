import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

late List<CameraDescription> _cameras;

// Future<void> main() async {
//   runApp(const CameraApp());
// }

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    myPrint('before init camera'); //
    initCamera();
    myPrint('after init camera');
  }

  void initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    myPrint('await init camera');
    _cameras =
        await availableCameras(); // 调用await后, initCamera函数会停止,会执行 initState()函数中的initCamera()的下一行
    myPrint('finished init camera');
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      isCameraInitialized = true;
      if (!mounted) {
        return;
      }
      setState(() {
        myPrint('刷新界面。。。 ');
      });
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myPrint('build ... ');
    if (!isCameraInitialized) {
      myPrint('相机还没有初始化 ');
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text('初始化相机中 ....'),
        ),
      );
    }

    myPrint('相机初始化完成 ');
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
