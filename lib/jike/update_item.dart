import 'package:flutter/material.dart';
import 'update_item_model.dart';

class UpdatedItem extends StatelessWidget {
  final UpdatedItemModel model; //数据模型
  //构造函数语法糖，用来给model赋值
  UpdatedItem({Key? key, required this.model, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
        //用Column将上下两部分合体
        crossAxisAlignment: CrossAxisAlignment.start, //水平方向距左对齐
        children: <Widget>[
          buildTopRow(context), //上半部分
          buildBottomRow(context) //下半部分
        ]);
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
        //Padding控件用来设置整体边距
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0), //左边距和右边距为15
        child: Column(
            //Column控件用来垂直摆放子Widget
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start, //水平方向距左对齐
            children: <Widget>[
              // todo 计算文本的高度

              // 1 如果想简单点，可以预估一个文本长度（比如100），超过这个文本长度的两行文字，统一都展示“More”按钮；如果想精确点，
              // 算文本高度可以用TextPainter。具体用法可以参考auto_size_text控件：https://github.com/leisim/auto_size_text

              // 2 我的思路这样，先自定义一个statefulwidget，里面用过一个变量控制两个text，因为text是statelesswidget，
              // 无法动态去刷新，一个widget设置Maxlines=2，另一个不设置，more是一个floatbutton，
              // 点击事件里面实现setstate改变先前定义的变量就行了

              // 3 我是用Builder(builder: (Buildcontext context){})来创建description那个Text组件，然后就可以通过context.size.height获取Text的高度，然后就能判断按钮何时展示了

              // 4 请问老师，more按钮那里的左右渐隐是怎么实现的啊，我用TextOverflow.fade是向下渐隐的啊, 作者回复: 可以看下这个issue：https://github.com/flutter/flutter/issues/13631
              // 另外这种效果可以考虑用Button遮挡来实现

              // 5 优化布局，整个页面拆成多个有布局的哦，但是有GetX， obs 这个东西很好额， 把组件拆小

              Text(
                model.appDescription,
                maxLines: 2,
              ),
              //更新文案
              Padding(
                  //Padding控件用来设置边距
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0), //上边距为10
                  child: Text("${model.appVersion} • ${model.appSize} MB"))
            ]));
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
              child: Image.asset(model.appIcon, width: 80, height: 80) //图片控件//
              )),
      Expanded(
        //Expanded控件，用来拉伸中间区域
        child: Column(
          //Column控件，用来垂直摆放子Widget
          mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
          crossAxisAlignment: CrossAxisAlignment.start, //水平方向居左对齐
          children: <Widget>[
            Text(
              model.appName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ), //App名字
            Text(model.appDate, maxLines: 1), //App更新日期
          ],
        ),
      ),
      Padding(
          //Paddng控件，用来设置Widget间边距
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0), //右边距为10，其余均为0
          child: TextButton(
            //按钮控件
            child: Text("OPEN"),
            onPressed: onPressed, //点击回调
          ))
    ]);
  }
}
