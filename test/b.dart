// Can be extended
import 'a.dart';

// 可以写extends， 也可以写 implements  Vehicle
class Car extends Vehicle {
  int passengers = 4;

  @override
  void moveForward(int meters) {

  }
// ···
}

// Can be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}



// Can be extended, 只能 extends
final class Car2 extends Vehicle2 {

}

// ERROR: Cannot be implemented
// final class MockVehicle implements Vehicle2 {
  // @override
  // void moveForward() {
  //   // ...
  // }
// }

void testBaseClass2() {
// Can be constructed
  Vehicle2 myVehicle = Vehicle2();
}


// ERROR: Cannot be inherited, bad
// class Car3 extends Vehicle3 {
//   int passengers = 4;
// // ...
// }

// Can be implemented
class MockVehicle3 implements Vehicle3 {
  @override
  void moveForward(int meters) {
    // ...
  }
}

void testinterface3() {
// Can be constructed
  Vehicle3 myVehicle = Vehicle3();
}

void main() {

}



