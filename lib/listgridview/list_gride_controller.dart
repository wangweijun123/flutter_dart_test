import 'package:get/get.dart';

class ListOrGridController extends GetxController {
  var itemCount = 30.obs;

  void changeItemCount() {
    itemCount.value = 25;
  }
}
