import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favorite_gesture/favorite_animation_icon.dart';
import 'favorite_gesture/favorite_gesture.dart';

class TestAnimation extends StatefulWidget {
  @override
  State<TestAnimation> createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation> {
  @override
  Widget build(BuildContext context) {
    return FavoriteGesture(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
