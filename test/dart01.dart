import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';
import 'package:json_annotation/json_annotation.dart';

void testInt() {
  int a = 4;
  print(a);

  // String -> int
  var one = int.parse('1');
  assert(one == 1);

// String -> double
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);

// int -> String
  String oneAsString = 1.toString();
  assert(oneAsString == '1');

// double -> String
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');

  Int b = const Int();

  // 编译时常量
  const msPerSecond = 1000;
  const secondsUntilRetry = 5;
  const msUntilRetry = secondsUntilRetry * msPerSecond;

  var s1 = 'Single quotes work well for string literals.';
  var s2 = "Double quotes work just as well.";
  var s3 = 'It\'s easy to escape the string delimiter.';
  var s4 = "It's even easier to use the other delimiter.";

  var s5 = '''
You can create
multi-line strings like this one.
''';

  var s6 = """This is also a
multi-line string.""";

  // These work in a const string.
  const aConstNum = 0;
  // aConstNum = 2 常量不能再次赋值

  const aConstBool = true;
  const aConstString = 'a constant string';

// These do NOT work in a const string.
  var aNum = 0;
  var aBool = true;
  var aString = 'a string';
  const aConstList = [1, 2, 3];

  const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
}

/**
 * 空安全，与kotlin一样
 */
void testNull() {
  // int a = null; // invalid
  int? a2 = null;
  int? a3;
  print("a2 == a3 ? ${a2 == a3}");

  int? a; // = null
  a ??= 3; // 如果a为null才赋值哦  ?? 两个问号判空
  print(a); // <-- Prints 3.

  a ??= 5;
  print(a); // <-- Still prints 3.

  print(1 ?? 3); // <-- Prints 1.
  print(null ?? 12); // <-- Prints 12.
}

void upperCaseIt(String? str) {
  int? size = str?.length;
  print("size is $size");
}

void testCollection() {
  final aListOfString = [
    'one',
    'two',
    'three'
  ]; // 看来和kotlin一样，可以智能推断类型,推断类型是 List<String> 但是final必须加上
  List<String> aListOfString2 = ['one', 'two', 'three'];
  var aListOfString3 = ['one', 'two', 'three'];

  final aSetString = {'a', 'b', 'c'};
  // aSetString = {'a', 'b', 'c'}; // 也不能再次赋值

  Set<String> aSetString2 = {'a', 'b', 'c'};

  final aMap = {'one': 1, 'tow': 2};
  Map<String, int> aMap2 = {'one': 1, 'tow': 2};
  var value = aMap2['tow'];
  print("value = $value");

  // 手动指定类型
  final aListOfInts = <int>[];
  final aSetOfInts = <int>{};
  final aMapOfIntToDouble = <int, double>{};

  // 在使用子类型的内容初始化列表，但仍希望列表为 List <BaseType> 时，指定其类型很方便：

  // final aListOfBaseType = <BaseType>[SubType(), SubType()];

  final anEmptyListOfDouble = <double>[];
  final anEmptySetOfString = <String>{};
  final anEmptyMapOfDoublesToInts = <double, int>{}; // Map<double, int>
}

class BigObject {
  int anInt = 0;
  String aString = '';
  List<double> aList = [];
  bool _done = false;

  void allDone() {
    _done = true;
  }
}

BigObject fillBigObject(BigObject obj) {
  obj.aList = [11.0];
  obj.anInt = 3;
  return obj;
}

BigObject fillBigObject2(BigObject obj) {
  obj
    ..aList = [11.0]
    ..anInt = 3
    .._done = true;
  return obj;
}

void testMyClass() {
  var myClass = MyClass();
  myClass.aProperty = -100;
  print(myClass.aProperty);
}

class MyClass {
  int _aProperty = 0;

  int get aProperty => _aProperty;

  set aProperty(int value) {
    if (value >= 0) {
      print("called ...");
      _aProperty = value;
    } else {
      print("< 0");
    }
  }
}

class InvalidPriceException {}

class ShoppingCart {
  // 默认是私有变量
  final List<double> _prices = [];

  void addValue(double value) {
    if (value > 0) {
      _prices.add(value);
    } else {
      throw InvalidPriceException();
    }
  }

  /// get method
  double get total {
    double temp = 0;
    for (int i = 0; i < _prices.length; i++) {
      temp = temp + _prices[i];
    }
    return temp;
  }
}

void testShoppingCart() {
  var shoppingCart = ShoppingCart();
  shoppingCart.addValue(5.0);
  shoppingCart.addValue(25.0);
  try {
    shoppingCart.addValue(-10.0);
  } on InvalidPriceException catch (_, e) {
    print("e = $e");
  }
  print(shoppingCart.total);
}

// [] 可选
int sumUpToFive(int a, [int? b, int? c, int? d, int? e]) {
  int sum = a;
  if (b != null) sum += b;
  if (c != null) sum += c;
  if (d != null) sum += d;
  if (e != null) sum += e;
  return sum;
}

void testOptionalParams() {
  int total = sumUpToFive(1, 2);
  int otherTotal = sumUpToFive(1, 2, 3, 4, 5);
  print("total = $total, otherTotal = $otherTotal");
}

// 命名参数
void printName(String firstName, String lastName, {String? middleName}) {
  print('$firstName ${middleName ?? ''} $lastName');
}

void testOptionalParams2() {
  printName('Dash', 'Dartisan');
  printName('John', 'Smith', middleName: 'Who');
  // Named arguments can be placed anywhere in the argument list
  printName('John', middleName: 'Who', 'Smith');
}

void printName2(String firstName, String lastName, {String middleName = ''}) {
  print('$firstName $middleName $lastName');
}

// 虽然b是可null参数，但是必须传
int sumUp(int a, int? b) {
  if (b == null) {
    return a;
  }
  return a + b;
}

// 这样才是可选参数
int sumUp2(int a, [int? b, int? c]) {
  int temp = a;
  if (b != null) {
    temp += b;
  }
  if (c != null) {
    temp += c;
  }
  return temp;
}

// 我觉得命名的可选参数更加好一些哈, 清晰{}
int sumUp3(int a, {int? b, int? c = 90}) {
  int temp = a;
  if (b != null) {
    temp += b;
  }
  if (c != null) {
    temp += c;
  }
  return temp;
}

class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  // 命名的可选参数
  MyDataObject({
    this.anInt = 1,
    this.aString = 'Old!',
    this.aDouble = 2.0,
  });

  @override
  String toString() {
    return "[anInt = $anInt, aString = $aString, aDouble=$aDouble]";
  }

// Add your copyWith method here:
  MyDataObject copyWith(int? newInt, String? newString, double? newDouble) {
    var xx = MyDataObject(
        anInt: newInt ?? anInt,
        aString: newString ?? aString,
        aDouble: newDouble ?? aDouble);
    return xx;
  }
}

class MyDataObject2 {
  String? userName;
  int? age;
  MyDataObject2(this.userName, this.age);

  @override
  String toString() {
    return "[userName = $userName, age = $age]";
  }
}

typedef VoidFunction = void Function(int exeptionType);

class ExceptionWithMessage {
  final String message;
  const ExceptionWithMessage(this.message);
}

abstract class Logger {
  void logException(Type t, [String? msg]);
  void doneLogging();
}

void tryFunction(int exeptionType, VoidFunction untrustworthy, Logger logger) {
  try {
    untrustworthy(exeptionType);
  } on ExceptionWithMessage catch (e) {
    logger.logException(e.runtimeType, e.message);
  } on Exception {
    logger.logException(Exception);
  } finally {
    logger.doneLogging();
  }
}

void testException(int exeptionType) {
  tryFunction(exeptionType, execeptionFunc, MyLog());
}

class MyLog extends Logger {
  @override
  void doneLogging() {
    print("doneLogging");
  }

  @override
  void logException(Type t, [String? msg]) {
    print("t = $t, msg = $msg");
  }
}

void execeptionFunc(int exeptionType) {
  switch (exeptionType) {
    case 0:
      throw const ExceptionWithMessage("this is ExceptionWithMessage");
      break;
    case 1:
      throw Exception("this is Exception");
      break;
    default:
      break;
  }
}

class MyColor {
  int red;
  int green;
  int blue;

  MyColor(this.red, this.green, this.blue);
}

final color = MyColor(80, 80, 128);

class MyColor2 {
  int red;
  int green;
  int blue;
  // {} 表示 命名参数, required 不能为空
  MyColor2({required this.red, required this.green, required this.blue});
}

final color2 = MyColor2(red: 80, green: 80, blue: 80);

class MyClass2 {
  final int anInt;
  final String aString;
  final double aDouble;

  MyClass2(this.anInt, this.aString, this.aDouble);
}

class Point {
  double x, y;

  Point(this.x, this.y);

  // 为了允许一个类具有多个构造方法， Dart 支持命名构造方法：
  Point.origin()
      : x = 0,
        y = 0;
}

class MyColor3 {
  int red;
  int green;
  int blue;

  MyColor3(this.red, this.green, this.blue);

  MyColor3.xx()
      : red = 0,
        green = 0,
        blue = 4;
  @override
  String toString() {
    return "[blue = $blue]";
  }
}

void testGouzhao() {
  var point = Point.origin();

  var myColor3 = MyColor3.xx();
  print(myColor3.toString());
  MyColor3(1, 3, 4);
}

class Square extends Shape {}

class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromTypeName(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    throw ArgumentError('Unrecognized $typeName');
  }
}

class IntegerHolder {
  IntegerHolder();

  factory IntegerHolder.fromList(List<int> list) {
    if (list.length == 1) {
      return IntegerSingle(list[0]);
    } else if (list.length == 2) {
      return IntegerDouble(list[0], list[1]);
    } else if (list.length == 3) {
      return IntegerTriple(list[0], list[1], list[2]);
    } else {
      throw Error();
    }
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;
  IntegerSingle(this.a);
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;
  IntegerDouble(this.a, this.b);
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;
  IntegerTriple(this.a, this.b, this.c);
}

// 重定向构造方法
class Automobile {
  String make;
  String model;
  int mpg;

  // The main constructor for this class.
  Automobile(this.make, this.model, this.mpg);

  // Delegates to the main constructor.
  Automobile.hybrid(String make, String model) : this(make, model, 60);

  // Delegates to a named constructor
  Automobile.fancyHybrid() : this.hybrid('Futurecar', 'Mark 2');

  @override
  String toString() {
    return "[make = $make, model = $model, mpg = $mpg]";
  }
}

class Color {
  int red;
  int green;
  int blue;

  Color(this.red, this.green, this.blue);

  Color.black() : this(0, 0, 0);
}

// Const 构造方法
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final int x;
  // final 表示再也不能给它赋值
  final int y;

  const ImmutablePoint(this.x, this.y);
}

class Recipe {
  final List<String> ingredients;
  final int calories;
  final double milligramsOfSodium;

  // 用 const 关键字使其成为常量。
  const Recipe(this.ingredients, this.calories, this.milligramsOfSodium);
}

void testIterable() {
  Iterable<int> iterable = [1, 2, 3];
  // int value = iterable[1]; // bad
  var iterator = iterable.iterator;
  while (iterator.moveNext()) {
    print("iterator.current = ${iterator.current}");
  }
  print("##################");
  Iterable<int> iterable2 = [1, 2, 3];
  int value0 = iterable2.elementAt(0);
  int value1 = iterable2.elementAt(1);
  print("index 0 = $value0}, index 1 = $value1");

  const iterable3 = ['Salad', 'Popcorn', 'Toast'];
  for (final item in iterable3) {
    print(item);
  }

  Iterable<String> iterable4 = const ['Salad', 'Popcorn', 'Toast'];
  print('The first element is ${iterable4.first}');
  print('The last element is ${iterable4.last}');

  String element = iterable4.firstWhere((element) => element.length > 5);
  print("element = $element");
}

bool predicate(String item) {
  return item.length > 5;
}

void testFirstWhere() {
  const items = ['Salad', 'Popcorn', 'Toast', 'Lasagne'];

  // You can find with a simple expression:
  var foundItem1 = items.firstWhere((item) => item.length > 5);
  print(foundItem1);

  // Or try using a function block:
  var foundItem2 = items.firstWhere((item) {
    return item.length > 5;
  });
  print(foundItem2);

  // Or even pass in a function reference:
  var foundItem3 = items.firstWhere(predicate);
  print(foundItem3);

  // You can also use an `orElse` function in case no value is found!
  var foundItem4 = items.firstWhere(
    (item) => item.length > 10,
    // 可选的命名参数
    orElse: () => 'None!',
  );
  print(foundItem4);
}

// Implement the predicate of singleWhere
// with the following conditions
// * The element contains the character `'a'`
// * The element starts with the character `'M'`
String singleWhere(Iterable<String> items) {
  return items.singleWhere((item) => item.contains("a") && item.startsWith("M"),
      orElse: () => "no item");
}

void testsingleWhere() {
  Iterable<String> items = ['xxxa', 'dd'];
  var result = singleWhere(items);
  print("result = $result");
}

void testEveryAndAny() {
  Iterable<String> items = ['xxxaddd', 'ddeeeee'];
  bool flag = true;
  for (final item in items) {
    if (item.length < 5) {
      flag = false;
      break;
    }
  }
  print("flag = $flag");

  bool flag2 = items.every((item) => item.length >= 5);
  print("flag2 = $flag2");

  const items2 = ['Salad', 'Popcorn', 'Toast'];

  if (items2.any((item) => item.contains('a'))) {
    print('At least one item contains "a"');
  }

  if (items2.every((item) => item.length >= 5)) {
    print('All items have length >= 5');
  }
}

bool anyUserUnder18(Iterable<User> users) {
  return users.any((element) => element.age <= 18);
}

bool everyUserOver13(Iterable<User> users) {
  return users.every((element) => element.age > 13);
}

class User {
  String name;
  int age;

  User(
    this.name,
    this.age,
  );
  @override
  String toString() {
    return "[name = $name, age = $age]";
  }
}

void testUser() {
  Iterable<User> users = [
    User("duanxia", 21),
    User("yanyan", 19),
    User("xx", 50)
  ];
  print(anyUserUnder18(users));
  print(everyUserOver13(users));

  var filterUsers = users.where((element) => element.age >= 20);
  print(filterUsers.length);
  for (final item in filterUsers) {
    print(item);
  }
}

void testWhere() {
  var evenNumbers = const [1, -2, 3, 42].where((number) => number.isEven);

  for (final number in evenNumbers) {
    /// -2 is even.
    // 42 is even.
    print('$number is even.');
  }

  if (evenNumbers.any((number) => number.isNegative)) {
    print('evenNumbers contains negative numbers.');
  }

  // If no element satisfies the predicate, the output is empty.
  var largeNumbers = evenNumbers.where((number) => number > 1000);
  if (largeNumbers.isEmpty) {
    print('largeNumbers is empty!');
  }
}

void testMap() {
  var numbersByTwo = const [1, -2, 3, 42].map((number) => number * 2);
  print('Numbers: $numbersByTwo');
}

Iterable<EmailAddress> parseEmailAddresses(Iterable<String> strings) {
  return strings.map((s) => EmailAddress(s));
}

bool anyInvalidEmailAddress(Iterable<EmailAddress> emails) {
  return emails.any((email) => !isValidEmailAddress(email));
}

Iterable<EmailAddress> validEmailAddresses(Iterable<EmailAddress> emails) {
  return emails.where((email) => isValidEmailAddress(email));
}

bool isValidEmailAddress(EmailAddress email) {
  return email.address.contains("@");
}

class EmailAddress {
  final String address;

  EmailAddress(this.address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAddress &&
          runtimeType == other.runtimeType &&
          address == other.address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() {
    return 'EmailAddress{address: $address}';
  }
}

// Dart 异步编程

// 错误地使用异步函数

//是一个异步函数
Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

void testFuture() {
  fetchUserOrder();

  // Fetching user order...
  // Start sleeping
  // 5 seconds has passed
  // Large Latte
}

void testFanxing() {
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String>? aNullableListOfStrings;
  List<String?> aListOfNullableStrings = ['one', null, 'three'];

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.');
  print('aListOfNullableStrings is $aListOfNullableStrings.');
}

int? couldReturnNullButDoesnt() => -3;

void testDuanyan() {
  int? couldBeNullButIsnt = 1;
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt;
  int b = listThatCouldHoldNulls.first!; // first item in the list
  int c = couldReturnNullButDoesnt()!.abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

int? stringLength(String? nullableString) {
  return nullableString?.length;
}

void setDefault4Nullable(String? nullableString) {
  print(nullableString ?? 'alternate');
  print(nullableString != null ? nullableString : 'alternate');
}

void setDefault4Nullable2(String? nullableString) {
  // Both of the following set nullableString to 'alternate' if it is null
  nullableString ??= 'alternate';
  nullableString = nullableString != null ? nullableString : 'alternate';
  nullableString = nullableString ?? 'alternate';
}

abstract class Store {
  int? storedNullableValue;

  /// If [storedNullableValue] is currently `null`,
  /// set it to the result of [calculateValue]
  /// or `0` if [calculateValue] returns `null`.
  void updateStoredValue() {
    // ?? 判断可空对象
    storedNullableValue = calculateValue() ?? 100;
  }

  /// Calculates a value to be used,
  /// potentially `null`.
  int? calculateValue();
}

class Mystore extends Store {
  @override
  int? calculateValue() {
    return -100;
  }
}

void testMystore() {
  var mystore = Mystore();
  mystore.updateStoredValue();
  print("storedNullableValue = ${mystore.storedNullableValue}");
}

void tetNull() {
  String text;

  if (DateTime.now().hour < 12) {
    text = "It's morning! Let's make aloo paratha!";
  } else {
    text = "It's afternoon! Let's make biryani!";
  }
  // text 一定是有值得
  print(text);
  print(text.length);
}

int getLength(String? str) {
  // Add null check here
  if (str == null) {
    return 0;
  }
  return str.length;
}

// 有时变量（类中的字段或顶级变量）应该是不可为 null 的，但不能立即为它们赋值。对于类似的情况，请使用 late关键字
class Meal {
  late String _description;

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

void testLate() {
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
}

// late 解决循环引用
class Team {
  late final Coach coach;
}

class Coach {
  late final Team team;
}

void testXunhuan() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}

/// 多行注释
/// 多行注释
/// 多行注释
int _computeValue() {
  print('In _computeValue...');
  return 3;
}

// this is a class
class CachedValueProvider {
  // late 修饰创建对象不会赋值
  // late final _cache = _computeValue();

  // 如果没有late修饰属性, 创建对象的时候就会赋值，所以_computeValue()这个函数就会被调用
  final _cache = _computeValue();
  int get value => _cache;
}

/* Comments like these are also supported */
void testCache() {
  print('Calling constructor...');
  var provider = CachedValueProvider();
  print('Getting value...');
  print('The value is ${provider.value}!');
}

class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

// 单继承。
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

void testSpacecraft() {
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
}

enum PlanetType { terrestrial, gas, ice }

mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

// 现在你只需使用 Mixin 的方式继承这个类就可将该类中的功能添加给其它类。
class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(super.name, super.launchDate);
}

void testmixin() {
  var pilotedCraft = PilotedCraft("duanxia", DateTime.now());
  pilotedCraft.describeCrew();
}

// class 被其他class 实现，什么鬼
class MockSpaceship implements Spacecraft {
  @override
  DateTime? launchDate;

  @override
  late String name;

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  // TODO: implement launchYear
  int? get launchYear => throw UnimplementedError();
  // ···
}

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

void testType() {
  Object name = 'Bob';
  String name2 = 'Bob';
  if (name is String) {
    print("object name is string");
  }

  dynamic name3 = 'Bob';
  if (name3 is String) {
    print("dynamic name is string");
  } else {
    print("not string");
  }

  // 对局部变量 使用var
  var name4 = "bob";

  // 常量(编译时常量)， const 变量是编译时常量
  const name5 = 'Bob'; // Without a type annotation
  // name5 = "" bad

  final String nickname = 'Bobby';
  // nickname = ""

  var foo = const [];
  foo = [1, 2, 3]; // Was const []
  foo.add(1);

  final bar = const [];

  const baz = []; // Equivalent to `const []`
  // baz = [42]; // Error: Constant variables can't be assigned a value.

  const Object i = 3; // Where i is a const Object with an int value...
  const list = [i as int]; // Use a typecast.

  // map is Map<int, String>
  const map = {if (i is int) i: 'int'}; // Use is and collection if.
  const set = {if (list is List<int>) ...list}; // ...and a spread.
  print("set = $set");
}

// 虽然final对象无法修改，但其字段可以更改。相比之下，const对象及其字段无法更改：它们是不可变的。

class MyBean {
  int age;
  MyBean(this.age);
}

void testType2() {
  final myBean = MyBean(5);
  myBean.age = 100; // 属性是可以修改，和java一样
  print(myBean.age);
  // final 变量智能设置一次
  // myBean = MyBean(20); // bad
}

void testOperate() {
  int a;
  int b;

  a = 0;
  b = ++a; // Increment a before b gets its value.
  assert(a == b); // 1 == 1

  a = 0;
  b = a++; // Increment a after b gets its value.
  assert(a != b); // 1 != 0

  a = 0;
  b = --a; // Decrement a before b gets its value.
  assert(a == b); // -1 == -1

  a = 0;
  b = a--; // Decrement a after b gets its value.
  assert(a != b); // -1 != 0

  // Assign value to a
  int c = 5;
// Assign value to b if b is null; otherwise, b stays the same
  double? d;
  d ??= c as double?;

  var paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

  var sb = StringBuffer();
  sb.write('foo');
  // ..write('bar'); // Error: method 'write' isn't defined for 'void'.
}

// Slightly longer version uses ?: operator.
String playerName(String? name) => name != null ? name : 'Guest';
String playerName3(String? name) => name ??= 'Guest';

// Very long version uses if-else statement.
String playerName2(String? name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}

void zhushi() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}

void yufa() {
  var record = ('first', a: 2, b: true, 'last');
  print(record.$1); // Prints 'first'
  print(record.a); // Prints 2
  print(record.b); // Prints true
  print(record.$2); // Prints 'last'

  var elements = <String>{};
  elements.add('fluorine');
  elements.add('halogens');

  var gifts = Map<String, String>();
  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';

  var nobleGases = Map<int, String>();
  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';

  var gifts2 = {'first': 'partridge'};
  gifts2['fourth'] = 'calling birds'; // Add a key-value pair

  var list = [1, 2, 3];
  var list2 = [0, ...list];
  assert(list2.length == 4);
}

void testIf() {
  bool promoActive = false;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav.length);
}

abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

// 别名, 给一个集合取别名
typedef IntList = List<int>;
// 定义一个函数的名字
typedef Comparee<T> = int Function(T a, T b);
int sort(int a, int b) => a - b;

void testtypeDef() {
  IntList il = [1, 2, 3];
  assert(sort is Comparee<int>); // True!
}

void testTypeSystem() {
  var arguments = {'argA': 'hello', 'argB': 42}; // Map<String, Object>
  Map<String, dynamic> arguments2 = {'argA': 'hello', 'argB': 42};
}

void testSwitchCase() {
  var obj = ['a', 'b'];
  const a = 'a';
  const b = 'b';
  switch (obj) {
    // List pattern [a, b] matches obj first if obj is a list with two fields,
    // then if its fields match the constant subpatterns 'a' and 'b'.
    case [a, b]:
      print('$a, $b');
  }

  int color = 2;
  var isPrimary = switch (color) { 1 || 2 || 3 => true, _ => false };
}

void testJson() {
  var json = {
    'user': ['Lily', 13]
  };
  // var {'user': [name, age]} = json;
  if (json is Map<String, Object?> &&
      json.length == 1 &&
      json.containsKey('user')) {
    var user = json['user'];
    if (user is List<Object> &&
        user.length == 2 &&
        user[0] is String &&
        user[1] is int) {
      var name = user[0] as String;
      var age = user[1] as int;
      print('User $name is $age years old.');
    }
  }

  if (json case {'user': [String name, int age]}) {
    print('User $name is $age years old.');
  }

  switch ((1, "2")) {
    // Does not match.
    case (int a, String b):
      print("int a, String b ");
      break;
    case (int a, int b):
      print("int a, int b ");
      break;
  }
}

void enableFlags({bool? bold, bool? hidden, required int? age}) {
  print("bold = $bold, hidden = $hidden, age = $age");
}

String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

void testSay() {
  // assert(say('Bob', 'Howdy') == 'Bob says Howdy');

  assert(say('Bob', 'Howdy', 'smoke signal') ==
      'Bob says Howdy with a smoke signal');
}

void printElement(int element) {
  print(element);
}

// (匿名函数) 函数给变量赋值, 注意函数的参数都没有类型
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';

void testfunction() {
  const list2 = ['apples', 'bananas', 'oranges'];
  list2.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });

  var list = [1, 2, 3];
// Pass printElement as a parameter.
  list.forEach(printElement);
  assert(loudify('hello') == '!!! HELLO !!!');
}

void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void testfunction2() {
  Function x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);
  print("....");
  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}

(String, int) multiReturn() {
  return ('something', 42);
}

void printInt(int i) {
  print("i = $i");
}

void testLooper() {
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }

  for (final c in callbacks) {
    c();
  }

  var collection = [1, 2, 3];
  collection.forEach(printInt); // 1 2 3
}

// 与java不一样，不需要break
void testSwitchCase2() {
  var command = 'xxx';
  switch (command) {
    case 'CLOSED':
      print("executeClosed");
    case 'PENDING':
      print("executePending");
    case 'APPROVED':
      print("APPROVED");
    case 'DENIED':
      print("DENIED");
    case 'OPEN':
      print("OPEN");
    default:
      print("executeUnknown");
  }
}

void testSwitchCase3() {
  var command = 'CLOSED';
  // 与kotlin一样，有表达式
  var token = switch (command) {
    'CLOSED' => "executeClosed",
    _ => throw FormatException('Invalid')
  };
  print("token = $token");
}

sealed class Shape2 {}

class Square2 implements Shape2 {
  final double length;
  Square2(this.length);
}

class Circle2 implements Shape2 {
  final double radius;
  Circle2(this.radius);
}

// 增加子类型，导致switch编译器不过
// class CircleAuto implements Shape2 {
//   final double radius;
//   CircleAuto(this.radius);
// }

double calculateArea(Shape2 shape) => switch (shape) {
      Square2(length: var l) => l * l,
      Circle2(radius: var r) => r * r * r
    };

void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // Allow callers to see the exception.
  }
}

void testException2() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  } finally {
    print('execute finally ...');
  }
}

void testPoint() {
  var p1 = Point(2, 2);

  var p = const ImmutablePoint(2, 2);
  // p = const ImmutablePoint(3, 5);

  // 值一样，产生的是同一个对象，否则不是
  var a = const ImmutablePoint(1, 1);
  var b = const ImmutablePoint(1, 1);

  assert(identical(a, b)); // They are the same instance!
}

// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void testYingShi() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}

// 类变量和方法
class Queue {
  static const initialCapacity = 16;
// ···
}

void testDartType() {
  // dart 静态类型语言，虽然有dynamic 类型， 与java一样，但是js是动态类型语言，
  var a; // 这样是dynamic
  var b = 12; // 这里赋值之后就是int
  // int a;
  a = 12;
  print("$a, a is ${a is int}");
  a = 'sdf';
  print("$a, a is ${a is String}");
}

class MyConst {
  // 类级别的常量必须加static const
  static const max = 100;
  final int a;

  MyConst(this.a);
}

void testConst() {
  var myConst = MyConst(1);
  print("myConst.a = ${myConst.a}");
}

void testJsonDecode() {
  const jsonString =
      '{"text": "foo", "value": 1, "status": false, "extra": null}';

  ///
  final data = jsonDecode(jsonString);
  print(data['text']); // foo
  print('is a int = ${data['value']}'); // 1
  print(data['status']); // false
  print(data['extra']); // null
  ///
  const jsonArray = '''
    [{"text": "foo", "value": 1, "status": true},
     {"text": "bar", "value": 2, "status": false}]
  ''';

  ///
  final List<dynamic> dataList = jsonDecode(jsonArray);
  print(dataList[0]); // {text: foo, value: 1, status: true}
  print(dataList[1]); // {text: bar, value: 2, status: false}
  ///
  final item = dataList[0];
  print(item['text']); // foo
  print(item['value']); // 1
  print(item['status']); // false
}

void parseDataTime() {
  var date = DateTime.parse('1969-07-20 20:18:04Z');
  print(date.toString());
}

void main() {
  parseDataTime();

  // testJsonDecode();

  // testDartType();

  // testYingShi();

  // testPoint();

  // testException2();

  // testSwitchCase3();

  // testSwitchCase2();

  // testLooper();

  // testfunction2();

  // testfunction();

  // testSay();

  // enableFlags(age: 1, bold: true, hidden: false);
  // enableFlags(age: null, bold: true);

  // testJson();

  // testSwitchCase();

  // testtypeDef();

  // testIf();

  // yufa();

  // testType2();

  // testType();

  // testmixin();

  // testCache();

  // testXunhuan();

  // testLate();

  // testMystore();

  // testDuanyan();

  // testFanxing();
  // testFuture();

  // print(createOrderMessage());

  // testMap();

  // testWhere();

  // testUser();

  // testEveryAndAny();

  // testsingleWhere();

  // testFirstWhere();

  // testIterable();

  // var immutablePoint = const ImmutablePoint(1, 2);
  // immutablePoint.x = 3;

  // var automobile = Automobile.fancyHybrid();
  // print(automobile);

  // var shape = Shape.fromTypeName("circle");
  // print(shape);

  // testGouzhao()
  // testException(1);

  // var a2 = MyDataObject2("duanxia", 18);
  // print("a2 = $a2");

  // var a1 = MyDataObject(anInt: 100);
  // print("a1 = $a1");

  // var a1 = MyDataObject();
  // print("a1 = $a1");

  //
  // var copyWith = a1.copyWith(100, null, null);
  // print("copyWith = $copyWith");

  // print(sumUp3(1, b:3, c:4));
  // print(sumUp3(1, b:3));
  // print(sumUp3(1));

  // print(sumUp2(1));
  // print(sumUp2(1, 6));
  // print(sumUp2(1, 6, 3));

  // print(sumUp(1, null)); //
  // print(sumUp(2, 4)); //

  // testOptionalParams2();
  // testOptionalParams();
  // testShoppingCart();
  // testInt();
  // testNull();
  // String? str;
  // upperCaseIt(str);
  testCollection();
  // testMyClass();
}
