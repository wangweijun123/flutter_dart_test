import 'package:fultter_dart_sample/log_util.dart';
import 'package:get/get.dart';

import '../gen/assets.gen.dart';

class MinePageController extends GetxController {
  // _imagePath, 导入到其他文件的_xxx 属性不能使用
  var _imagePath = Assets.image.defaultPhoto.path.obs;

  // 定义imagePath的get函数提供给外面使用
  String get imagePath => _imagePath.value;
  // set 函数
  set imagePath(String url) => _imagePath.value = url;

  final _zan = '0'.obs;
  String get zan => _zan.value;

  final _focusAccount = '0'.obs;
  String get focusAccount => _focusAccount.value;

  final _followAccount = '0'.obs;
  String get followAccount => _followAccount.value;

  Future<void> fetchUserZan() async {
    myPrint('Awaiting user order...');
    var tempZan = await _fetchUserZan();
    _zan.value = tempZan;
    _focusAccount.value = '1234';
    _followAccount.value = '157852';

    myPrint('Your tempZan: $tempZan');
  }

  Future<String> _fetchUserZan() {
    // Imagine that this function is more complex and slow.
    return Future.delayed(const Duration(seconds: 2), () => '100000');
  }
}
