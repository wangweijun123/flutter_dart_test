import 'dart:async';

void test() {
  // List<Object>
  var arr = [1, 2, 's'];
  arr.forEach(
      (v) => print('The value is ${v}, and the type is ${v.runtimeType}'));
}

bool isZero(int number) {
  //判断整数是否为0
  return number == 0;
}

void printInfo(int number, Function check) {
  //用check函数来判断整数是否为0
  print("$number is Zero: ${check(number)}");
}

void testFunction() {
  Function f = isZero;
  int x = 10;
  int y = 0;
  printInfo(x, f); // 输出 10 is Zero: false
  printInfo(y, f); // 输出 0 is Zero: true
}

int add(int number1, int number2) {
  //判断整数是否为0
  return number1 + number2;
}

void printInfo2(int n1, int n2, Function xxx) {
  //用check函数来判断整数是否为0
  print("$n1 +  $n2 = ${xxx(n1, n2)}");
}

void testFunction2() {
  Function f = add;
  printInfo2(10, 22, f);
}

//要达到可选命名参数的用法，那就在定义函数的时候给参数加上 {}
void enable1Flags({required bool bold, bool? hidden}) =>
    print("$bold , $hidden");

//定义可选命名参数时增加默认值
void enable2Flags({bool bold = true, bool hidden = false}) =>
    print("$bold ,$hidden");

//可忽略的参数在函数定义时用[]符号指定
void enable3Flags(bool bold, [bool? hidden]) => print("$bold ,$hidden");

//定义可忽略参数时增加默认值
void enable4Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");

void testOption() {
//可选命名参数函数调用
  enable1Flags(bold: true, hidden: false); //true, false
  enable1Flags(bold: true); //true, null
  enable2Flags(bold: false); //false, false

//可忽略参数函数调用
  enable3Flags(true, false); //true, false
  enable3Flags(
    true,
  ); //true, null
  enable4Flags(true); //true, false
  enable4Flags(true, true); // true, true
}

class Point {
  num x, y;
  static num factor = 0;
  //语法糖，等同于在函数体内：this.x = x;this.y = y;
  Point(this.x, this.y);
  void printInfo() => print('($x, $y)');
  static void printZValue() => print('$factor');
}

void testClass() {
  var p = Point(100, 200); // new 关键字可以省略
  p.printInfo(); // 输出(100, 200);
  Point.factor = 10;
  Point.printZValue(); // 输出10
}

class Point2 {
  Point2() {
    print("Point2 构造函数");
  }
  num x = 0, y = 0;
  void printInfo() => print('($x,$y)');
}

//Vector继承自Point
class Vector extends Point2 {
  /**
   *
   *  日志如下：先调用父亲构造函数
   *  Point2 构造函数
      Vector构造函数
   */
  Vector() {
    print("Vector构造函数");
  }
  num z = 0;
  @override
  void printInfo() => print('($x,$y,$z)'); //覆写了printInfo实现
}

//Coordinate是对Point的接口实现, class 也能被implement，需要全部重写
class Coordinate implements Point2 {
  num x = 0, y = 0; //成员变量需要重新声明
  void printInfo() => print('($x,$y)'); //成员函数需要重新声明实现
}

void testExtendAndImplements() {
  var xxx = Vector();
  xxx
    ..x = 1
    ..y = 2
    ..z = 3; //级联运算符，等同于xxx.x=1; xxx.y=2;xxx.z=3;
  xxx.printInfo(); //输出(1,2,3)

  var yyy = Coordinate();
  yyy
    ..x = 1
    ..y = 2; //级联运算符，等同于yyy.x=1; yyy.y=2;
  yyy.printInfo(); //输出(1,2)
  print(yyy is Point); //true
  print(yyy is Coordinate); //true
}

mixin Point3 {
  num x = 0, y = 0;
  void printInfo() => print('($x,$y)');
}

class Coordinate2 with Point3 {}

void testMixinWith() {
  var yyy = Coordinate();
  print('${yyy.y}');
  print(yyy is Point); //true
  print(yyy is Coordinate); //true
}

class Meta {
  double price;
  String name;

  Meta(this.price, this.name);
}

//定义商品Item类
class Item extends Meta {
  Item(name, price) : super(price, name);
}

//定义购物车类
class ShoppingCart extends Meta {
  String name;
  DateTime date;
  String? code;
  List<Item> bookings = [];

  // 函数没有写返回值，它是动态的

  @override
  double get price {
    double sum = 0.0;
    for (var i in bookings) {
      sum += i.price;
    }
    return sum;
  }

//默认初始化方法，转发到withCode里
  ShoppingCart({name}) : this.withCode(name: name, code: null);
  //withCode初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({required this.name, this.code})
      : date = DateTime.now(),
        super(0.0, name);

  @override
  getInfo() {
    return '购物车信息:\n-----------------------------\n用户名: $name\n优惠码: ${code ?? "没有"}\n总价: $price\n日期: $date\n-----------------------------';
  }
}

void testShop() {
  ShoppingCart sc = ShoppingCart.withCode(name: '张三', code: '123456');
  sc.bookings = [Item('苹果', 10.0), Item('鸭梨', 20.0)];
  print(sc.getInfo());
  ShoppingCart sc2 = ShoppingCart(name: '李四');
  sc2.bookings = [Item('香蕉', 15.0), Item('西瓜', 40.0)];
  print(sc2.getInfo());
}

void est() {
  scheduleMicrotask(() => print('This is a microtask'));
}

void testFutrue() {
  Future(() => print('Running in Future 1')); //下一个事件循环输出字符串

  //上一个事件循环结束后，连续输出三段字符串
  // Future(() => print('Running in Future 2'))
  //     .then((_) => print('and then 1'))
  // .then((value) => print('and then 2’))
}

void testMap() {
  Map<String, Object> map1 = {'name': 'duanxia', 'age': 27};
  var name = map1['name'];
  print('name.runtimeType= ${name.runtimeType}');
  if (name is String) {
    print('$name is String');
  }
}

void main() {
  // testMap();
  // testShop();

  testExtendAndImplements();

  // testClass();

  // testFunction();

  // testFunction2();
  // test();
}
