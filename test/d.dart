import 'c.dart';

// 默认情况下，两个dart不认识，就算是在同一个包地下, 没有作用域这一说
// todo 为什么没有作用域关键字
void main() {
  var classInC = ClassInC();
  classInC.a = 100;
  print("${classInC.a}");
}
