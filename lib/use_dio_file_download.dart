import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:path_provider/path_provider.dart';

const String TAG = "duanxia";

class FileDownloadPage extends StatefulWidget {
  FileDownloadPage();

  @override
  _FileDownloadPageState createState() => _FileDownloadPageState();
}

class _FileDownloadPageState extends State<FileDownloadPage> {
  _FileDownloadPageState();

  final dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: const Text(
              "长按文本下载",
              style: TextStyle(fontSize: 40),
            ),
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: <Widget>[
                        TextButton(
                          child: const Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('下载'),
                          onPressed: () {
                            downloadFile();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> downloadFile() async {
    final Directory tempDir = await getTemporaryDirectory();
    var path = '${tempDir.path}/movie.mp4';
    print('$TAG path = $path');

    var response = await dio.download(
      'https://www.w3schools.com/html/movie.mp4',
      path,
      onReceiveProgress: (count, total) {
        print(
            '$TAG count = $count, total=$total, 完成度 ${count / (total * 1.0)}');
      },
    );
    print('$TAG response statusCode = ${response.statusCode}');
  }
}
