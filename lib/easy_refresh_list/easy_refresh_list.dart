import 'package:flutter/cupertino.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:fultter_dart_sample/log_util.dart';

import 'user_controller.dart';

class TestEasyRefreshList extends StatefulWidget {
  @override
  State<TestEasyRefreshList> createState() => _TestEasyRefreshListState();
}

class _TestEasyRefreshListState extends State<TestEasyRefreshList> {
  UserController controller = UserController();

  int page = 1;
  int mum = 20;

  @override
  void initState() {
    super.initState();
    controller.fetchVideoList(page, mum).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        onRefresh: () async {
          myPrint('onrefresh ...');
        },
        onLoad: () async {
          myPrint('onLoad ...');
          controller.fetchVideoList(++page, mum);
        },
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text('index = $index');
          },
          itemCount: controller.dataList.length,
        ));
  }
}
