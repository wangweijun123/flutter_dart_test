import 'package:get/get.dart';

import '../gen/assets.gen.dart';

class MinePageController extends GetxController {
  // _imagePath, 导入到其他文件的_xxx 属性不能使用
  var imagePath = Assets.image.defaultPhoto.path.obs;
}
