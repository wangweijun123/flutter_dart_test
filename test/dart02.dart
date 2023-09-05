import 'dart:math';


const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  double x, y;
  Point(this.x, this.y);

  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;

  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void testPoint() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}

class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

void testEmpleoyee() {
  var employee = Employee.fromJson({});
  print(employee);
}

class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}

void testVector3d() {
  var vector3d = Vector3d(1, 3, 5);
  print("x = ${vector3d.x}, y = ${vector3d.y}, z = ${vector3d.z}");
}

class Point2 {
  double x, y;

  // The main constructor for this class.
  Point2(this.x, this.y);

  // Delegates to the main constructor.
  Point2.alongXAxis(double x) : this(x, 0);
}

class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

void testVector() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}

class Rectangle {
  // 每个实例变量都有一个隐式 getter
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void testGetterSetter() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}

class Television {
  // ···
  set contrast(int value) {
    //...
    print("Television ... $value");
  }
}

class SmartTelevision extends Television {

  @override
  // 注意是 num, 父类型
  set contrast(num value) {
    print("SmartTelevision ... $value");
  }
}

void testSmartTelevision() {
  SmartTelevision().contrast = 100;
}


/* 不能声明任何生成构造函数 */
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

class Musician with Musical {
  // ···
}

class Maestro with Musical {
  // ···
}

void testMusician() {
  // with Musical一下， 就可以调用mixin中的函数
  Musician().entertainMe();
  Maestro().entertainMe();
}

enum Color { red, green, blue }

void testColor() {
  const favoriteColor = Color.blue;
  if (favoriteColor == Color.blue) {
    print('Your favorite color is blue!');
  }
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);

  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);

  var aColor = Color.blue;
  switch (aColor) {
    case Color.red:
      print('Red as roses!');
    case Color.green:
      print('Green as grass!');
    default: // Without this, you see a WARNING.
      print(aColor); // 'Color.blue'
  }
  print(Color.blue.name); // 'blue'

  print(Vehicle.car.carbonFootprint);
}
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}


// 扩展方法 (接收器String)
extension NumberParsing on String {
  int parseInt() {
    print("parseInt 是一个对类String扩展函数");
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

//未命名的扩展
extension on String {
  bool get isBlank => trim().isEmpty;
}

extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}

void testExt() {
  // var parse = int.parse('42');

  // '42'.parseInt() 没有这个函数
  print('42'.parseInt()); // Use an extension method.

  var v = '2';
  print(v.parseInt()); // Output: 2

  print(NumberParsing('42').parseInt());

  print('42.23'.parseDouble());

  print('     '.isBlank);
  // dynamic d = '2';
  // print(d.parseInt()); // Runtime exception: NoSuchMethodError
  var list = ['a', 'b', 'c'];
  print("调用扩展get函数() doubleLength = ${list.doubleLength}");
}

class WannabeFunction {
  // call函数在调用的时候很特殊, 使用对象(), 传参数
  String call(String a, String b, String c) => '$a $b $c!';
}

void testCall() {
  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');
  print(out);
}

void main() {
  testCall();

  // testExt();
  // testColor();

  // testMusician();

  // testSmartTelevision();

  // testGetterSetter();

  // testVector();

  // testVector3d();

  // testEmpleoyee();

  // testPoint();
}