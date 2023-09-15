class UpdatedItemModel {
  String appIcon; //App图标
  String appName; //App名称
  String appSize; //App大小
  String appDate; //App更新日期
  String appDescription; //App更新文案
  String appVersion; //App版本
  //构造函数语法糖，为属性赋值
  UpdatedItemModel(
      {required this.appIcon,
      required this.appName,
      required this.appSize,
      required this.appDate,
      required this.appDescription,
      required this.appVersion});
}
