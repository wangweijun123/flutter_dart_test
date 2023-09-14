abstract class Vehicle {
  void moveForward(int meters);
}

base class Vehicle2 {
  void moveForward(int meters) {
    // 定义成base， 这个函数不能被覆盖，只能自己实现
  }
}

interface class Vehicle3 {
  void moveForward(int meters) {
    // ...
  }
}

// dart 中的接口相当于 java 中的接口
abstract class Vehicle4 {
  void moveForward(int meters);
}

/* 可以在本类中集成 */
class Car3 extends Vehicle3 {
  int passengers = 4;
// ...
}

mixin class Both {}

class UseAsMixin with Both {}

class UseAsSuperclass extends Both {}
