//示例：同步函数
import 'dart:io';

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() => Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

void main() {
  print('Fetching user order...');
  print(createOrderMessage());

  var duration = const Duration(seconds: 5);
  print('Start sleeping');
  sleep(duration);
  print('5 seconds has passed');

  /**
   *
   * Fetching user order...
      Your order is: Instance of 'Future<String>'
      Start sleeping
      5 seconds has passed
   *
   */
}
