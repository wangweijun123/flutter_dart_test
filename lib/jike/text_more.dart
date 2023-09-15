import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

import 'update_item_model.dart';

class UpdateItemWidget extends StatefulWidget {
  final UpdatedItemModel model;
  final onPressed;

  UpdateItemWidget({Key? key, required this.model, this.onPressed})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UpdateItemState();
  }
}

class _UpdateItemState extends State<UpdateItemWidget> {
  bool collapse = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopRow(context),
        buildBottomRow(context),
      ],
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(//Row控件，用来水平摆放子Widget
        children: <Widget>[
      Padding(
          //Paddng控件，用来设置Image控件边距
          padding: EdgeInsets.all(10), //上下左右边距均为10
          child: ClipRRect(
              //圆角矩形裁剪控件
              borderRadius: BorderRadius.circular(8.0), //圆角半径为8
              child: Image.asset(widget.model.appIcon,
                  width: 80, height: 80) //图片控件//
              )),
      Expanded(
        //Expanded控件，用来拉伸中间区域
        child: Column(
          //Column控件，用来垂直摆放子Widget
          mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
          crossAxisAlignment: CrossAxisAlignment.start, //水平方向居左对齐
          children: <Widget>[
            Text(widget.model.appName, maxLines: 1), //App名字
            Text(widget.model.appDate, maxLines: 1), //App更新日期
          ],
        ),
      ),
      Padding(
          //Paddng控件，用来设置Widget间边距
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0), //右边距为10，其余均为0
          child: TextButton(
            //按钮控件
            child: Text("OPEN"),
            onPressed: () {
              widget.onPressed?.call();
            }, //点击回调
          ))
    ]);
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(widget.model.appDescription,
                    maxLines: collapse ? 2 : null,
                    overflow: collapse ? TextOverflow.ellipsis : null),
              ),
              Container(
                  width: !collapse ? 0 : null,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        collapse = false;
                      });
                    },
                    child: Text(
                      'More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child:
                Text("${widget.model.appVersion} • ${widget.model.appSize} MB"),
          )
        ],
      ),
    );
  }
}
