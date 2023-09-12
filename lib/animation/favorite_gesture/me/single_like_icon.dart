import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

import '../favorite_animation_icon.dart';
import '../favorite_gesture.dart';

typedef OnAnimationComplete = Function(SingleLikeIcon singleLikeIcon);

class SingleLikeIcon extends StatefulWidget {
  final Offset globalPosition;
  final OnAnimationComplete onAnimationComplete;
  SingleLikeIcon(this.globalPosition, this.onAnimationComplete);

  @override
  State<SingleLikeIcon> createState() => _SingleLikeIconState();
}

class _SingleLikeIconState extends State<SingleLikeIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  static const _duration = 3000;

  // 展示的进度值为0.1
  static const double appearValue = 0.1;

  // 消失的进度值为0.8
  static const double dismissValue = 0.8;

  final double angle = pi / 10 * (2 * Random().nextDouble() - 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );

    _animationController.addListener(() {
      // myPrint(
      // 'listener _animationController.value = ${_animationController.value}');
      // 控制器来控制重绘, 因为 _animationController.value会变化
      setState(() {});
    });
    myPrint(
        '_SingleLikeIconState widget = ${widget.hashCode}, _animationController=${_animationController.hashCode}');
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        myPrint(
            'animation status completed, 隐藏 widget = ${widget.hashCode}, _animationController=${_animationController.hashCode} and dispose');
        // _animationController.dispose();千万不要主动去调用把,跟随widget的状态
        widget.onAnimationComplete?.call(widget);
      }
    });

    startAnimation();
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
    // myPrint(
    //     'xxxxx _TestAnimation2State build opacity = $opacity, scale = $scale, widget = ${widget.hashCode}, _animationController = ${_animationController.hashCode}');

    return Positioned(
      left: widget.globalPosition.dx,
      top: widget.globalPosition.dy,
      child: tempRotate,
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

  void startAnimation() {
    myPrint('startAnimation ...');
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    myPrint('dispose ..._animationController=${_animationController.hashCode}');
    super.dispose();
    _animationController.dispose();
  }

  @override
  void deactivate() {
    myPrint(
        'deactivate ..._animationController=${_animationController.hashCode}');
    super.deactivate();
    _animationController.dispose();
  }
}
