import 'dart:math';
import 'package:flutter/material.dart';

import '../../log_util.dart';

class FavoriteAnimationIcon extends StatefulWidget {
  final Offset position;
  final double size;
  final Function? onAnimationComplete;

  const FavoriteAnimationIcon(
      {required Key key,
      required this.size,
      this.onAnimationComplete,
      required this.position})
      : super(key: key);

  @override
  State<FavoriteAnimationIcon> createState() => _FavoriteAnimationIconState();
}

class _FavoriteAnimationIconState extends State<FavoriteAnimationIcon>
    with TickerProviderStateMixin {
  /// 以下两个值在课程PPT里有计算方式
  // 展示的进度值为0.1
  static const double appearValue = 0.1;

  // 消失的进度值为0.8
  static const double dismissValue = 0.8;

  static const int _duration = 6000;
  late AnimationController _animationController;

  final double angle = pi / 10 * (2 * Random().nextDouble() - 1);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );
    myPrint(
        'xxxxxx _FavoriteAnimationIconState initState _animationController = ${_animationController.hashCode}');
    _animationController.addListener(() {
      myPrint('Animation listener 刷新 ...');
      setState(() {});
    });

    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myPrint(
        '_FavoriteAnimationIconState build..很重要._animationController.value = ${_animationController.value}');
    var content =
        Icon(Icons.favorite, size: widget.size, color: Colors.redAccent);

    double tempTop = widget.position.dy - widget.size / 2;
    double tempLeft = widget.position.dx - widget.size / 2;

    myPrint(
        'angle = $angle, scale=$scale, opacity = $opacity, tempTop=$tempTop, tempLeft = $tempLeft');
    var child = ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) => RadialGradient(
                colors: const [Color(0xFFEE6E6E), Color(0xFFF03F3F)],
                center: Alignment.topLeft.add(const Alignment(0.66, 0.66)))
            .createShader(bounds),
        child: Transform.rotate(
            angle: angle,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.bottomCenter,
              child: content,
            )));

    return Positioned(
        top: tempTop,
        left: tempLeft,
        child: Opacity(opacity: opacity, child: child));
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

  double get value {
    return _animationController.value;
  }

  Future<void> startAnimation() async {
    myPrint('startAnimation ...');
    await _animationController.forward();
    widget.onAnimationComplete?.call();
  }
}
