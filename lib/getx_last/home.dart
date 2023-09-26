import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/getx_last/list/third.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'second.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Home extends StatelessWidget {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    myPrint(' Home build ....');
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'clicks: ${controller.count}',
                )),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                myPrint('go to ...');
                Get.to(Second());
              },
            ),
            ElevatedButton(
              child: Text('Next Route 3'),
              onPressed: () {
                myPrint('go to third ...');
                Get.to(Third());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            controller.increment();
          }),
    );
  }
}
