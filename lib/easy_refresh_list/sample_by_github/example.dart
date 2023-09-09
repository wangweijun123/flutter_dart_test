import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../user_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EasyRefresh',
      home: EasyRefreshListviewTest(),
    );
  }
}

class EasyRefreshListviewTest extends StatefulWidget {
  const EasyRefreshListviewTest({Key? key}) : super(key: key);

  @override
  State<EasyRefreshListviewTest> createState() =>
      _EasyRefreshListviewTestState();
}

class _EasyRefreshListviewTestState extends State<EasyRefreshListviewTest> {
  int currentPage = 0;

  late EasyRefreshController _controller;
  UserController userController = UserController();
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    userController.fetchVideoList(currentPage, PAGE_NUM).then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyRefresh'),
      ),
      body: userController.dataList.isEmpty
          ? const Center(
              child: Text('加载中'),
            )
          : EasyRefresh(
              controller: _controller,
              header: const ClassicHeader(),
              footer: const ClassicFooter(),
              onRefresh: () async {
                myPrint('onRefresh ... ');

                // 加载完成之后，重置数据
                await userController.refresh();
                if (!mounted) {
                  return;
                }
                currentPage = 0;
                setState(() {});
                _controller.finishRefresh();
                _controller.resetFooter();
              },
              onLoad: () async {
                myPrint('onLoad ...');
                await userController.fetchVideoList(++currentPage, PAGE_NUM);
                if (!mounted) {
                  return;
                }
                setState(() {});

                _controller.finishLoad(userController.dataList.length >= 50
                    ? IndicatorResult.noMore
                    : IndicatorResult.success);
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      child: Text('${index + 1}'),
                    ),
                  );
                },
                itemCount: userController.dataList.length,
              ),
            ),
    );
  }
}
