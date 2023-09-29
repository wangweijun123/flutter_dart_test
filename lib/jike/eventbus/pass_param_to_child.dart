import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

class PassParamToChild extends StatefulWidget {
  @override
  State<PassParamToChild> createState() => _PassParamToChildState();
}

class _PassParamToChildState extends State<PassParamToChild> {
  int account = 0;

  void updateAccount() {
    setState(() {
      myPrint('parent change account');
      account++;
    });
  }

  @override
  Widget build(BuildContext context) {
    myPrint('parent build ....');
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 120,
        ),
        Text('account = $account'),
        ElevatedButton(
          child: const Text('父亲改变account'),
          onPressed: () {
            updateAccount();
          },
        ),
        SizedBox(
          height: 100,
        ),
        ChildWidget(account),
      ],
    ));
  }
}

class ChildWidget extends StatefulWidget {
  var account;
  ChildWidget(this.account);

  @override
  State<ChildWidget> createState() {
    myPrint('createState this = ${this.hashCode}');
    return _ChildWidgetState();
  }
}

class _ChildWidgetState extends State<ChildWidget> {
  void updateAccount() {
    setState(() {
      // 只刷新自己呀
      myPrint('child change account widget = ${widget.hashCode}');
      widget.account++;
    });
  }

  @override
  Widget build(BuildContext context) {
    myPrint('child build ...widget = ${widget.hashCode}.');
    return Container(
      child: Column(
        children: [
          Text('child account = ${widget.account}'),
          ElevatedButton(
            child: const Text('child 改变子account'),
            onPressed: () {
              updateAccount();
            },
          ),
        ],
      ),
    );
  }
}
