import 'package:fultter_dart_sample/log_util.dart';
import 'package:get/get.dart';

import '../gen/assets.gen.dart';

class MinePageController extends GetxController {
  // _imagePath, 导入到其他文件的_xxx 属性不能使用
  var imagePath = Assets.image.defaultPhoto.path.obs;
  var zan = 10.obs;

  Future<void> fetchUserZan() async {
    myPrint('Awaiting user order...');
    var tempZan = await _fetchUserZan();
    zan.value = tempZan;
    myPrint('Your tempZan: $tempZan');
  }

  Future<int> _fetchUserZan() {
    // Imagine that this function is more complex and slow.
    return Future.delayed(const Duration(seconds: 4), () => 100000);
  }
}
