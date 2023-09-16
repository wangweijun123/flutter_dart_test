import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExceptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Positioned(
            child: Container(
              height: 10,
              width: 10,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
