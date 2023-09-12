import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../favorite_animation_icon.dart';
import '../favorite_gesture.dart';

class TestAnimation2 extends StatefulWidget {
  @override
  State<TestAnimation2> createState() => _TestAnimation2State();
}

class _TestAnimation2State extends State<TestAnimation2>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  static const _duration = 6000;

  // 展示的进度值为0.1
  static const double appearValue = 0.1;

  // 消失的进度值为0.8
  static const double dismissValue = 0.8;

  final double angle = pi / 10 * (2 * Random().nextDouble() - 1);

  // 保存当前需要展示的icon, 后续来做
  List<Offset> iconOffsets = [];

  var globalPosition = Offset.zero;
  bool showLikeIcon = false;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );

    _animationController.addListener(() {
      myPrint(
          'listener _animationController.value = ${_animationController.value}');
      // 控制器来控制重绘, 因为 _animationController.value会变化
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        myPrint('animation status completed, 隐藏');
        setState(() {
          showLikeIcon = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var content =
        const Icon(Icons.favorite, size: 100, color: Colors.redAccent);

    var tempAlpha = Opacity(opacity: opacity, child: content);
    var tempScale = Transform.scale(
      scale: scale,
      child: tempAlpha,
    );
    var tempRotate = Transform.rotate(
      angle: angle,
      child: tempScale,
    );
    myPrint('_TestAnimation2State build opacity = $opacity, scale = $scale');

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
        // for (Offset item in iconOffsets)
        if (showLikeIcon)
          Positioned(
            left: globalPosition.dx,
            top: globalPosition.dy,
            child: tempRotate,
          ),
      ]),
    );
  }

  double get value {
    return _animationController.value;
  }

  // 需要得到的结果是透明度的进度值的百分比
  double get opacity {
    if (value < appearValue) {
      // 处于渐进阶段，播放透明度动画
      return value / appearValue;
    }
    if (value < dismissValue) {
      // 处于展示阶段，不需要动画
      return 1;
    }
    // 处于渐隐阶段，播放器透明度动画
    return (1 - value) / (1 - dismissValue);
  }

  // 需要计算缩放尺寸的占比
  double get scale {
    if (value < appearValue) {
      // 处于出现阶段
      return 1 + appearValue - value;
    }

    if (value < dismissValue) {
      // 处于正常展示阶段
      return 1;
    }

    // 处于消失放大阶段
    return 1 + (value - dismissValue) / (1 - dismissValue);
  }

  void onDoubleTap() {
    myPrint('onDoubleTap 双击');
    setState(() {
      // iconOffsets.add(globalPosition);
      showLikeIcon = true;
    });
    startAnimation();
  }

  void onDoubleTapDown(TapDownDetails details) {
    globalPosition = details.globalPosition;
    myPrint('onDoubleTapDown 获取位置 globalPosition = $globalPosition');
  }

  void startAnimation() {
    myPrint('startAnimation ...');
    _animationController.forward(from: 0.0);
  }
}
