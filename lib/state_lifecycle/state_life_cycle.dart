import 'package:flutter/material.dart';
import './page1.dart';

void main() => runApp(StateLifeCycle());

class StateLifeCycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Page1());
  }
}
