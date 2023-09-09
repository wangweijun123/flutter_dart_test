import 'package:fultter_dart_sample/easy_refresh_list/user_model.dart';

import '../log_util.dart';

const PAGE_NUM = 10;

class UserController {
  var dataList = <User>[];
  // 模拟网络
  Future<void> fetchVideoList(int page, int num) async {
    myPrint('$hashCode  ,Awaiting get user list page=$page, num=$num');
    var list = await _fetchUserList(page, num);
    dataList.addAll(list);
    myPrint('load finished');
  }

  Future<List<User>> _fetchUserList(int page, int num) {
    return Future.delayed(const Duration(seconds: 1), () {
      return List.generate(num, (index) => User(index, 'index = $index'));
    });
  }

  Future<void> refresh() async {
    myPrint('$hashCode  ,Awaiting get user list page=0, num=$num');
    var list = await _fetchUserList(0, PAGE_NUM);
    dataList.clear();
    dataList.addAll(list);
    myPrint('refresh finished:');
  }
}
