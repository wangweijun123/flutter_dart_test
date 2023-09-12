import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../favorite_animation_icon.dart';
import '../favorite_gesture.dart';
import 'single_like_icon.dart';

class TestAnimation2 extends StatefulWidget {
  @override
  State<TestAnimation2> createState() => _TestAnimation2State();
}

class _TestAnimation2State extends State<TestAnimation2>
    with TickerProviderStateMixin {
  // 保存当前需要展示的icon, 后续来做
  List<SingleLikeIcon> likeIncons = [];

  var globalPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    myPrint(
        '_TestAnimation2State build iconOffsets.length = ${likeIncons.length} ');

    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onDoubleTapDown: onDoubleTapDown,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
        // 红心
        for (SingleLikeIcon itemLikeIcon in likeIncons) itemLikeIcon
      ]),
    );
  }

  void onDoubleTap() {
    myPrint('onDoubleTap 双击');
    var singleLikeIcon = SingleLikeIcon(globalPosition, (likeIcon) {
      myPrint(
          'before remove likeIncons.length = ${likeIncons.length} , likeIcon = ${likeIcon.hashCode}');

      likeIncons.remove(likeIcon);
      setState(() {});
      myPrint('before remove likeIncons.length = ${likeIncons.length}');
    });
    myPrint('singleLikeIcon = ${singleLikeIcon.hashCode}');
    setState(() {
      likeIncons.add(singleLikeIcon);
    });
  }

  void onDoubleTapDown(TapDownDetails details) {
    globalPosition = details.globalPosition;
    myPrint('onDoubleTapDown 获取位置 globalPosition = $globalPosition');
  }
}
