// async 声明异步函数, await 在函数内部使用
Future<String> createOrderMessage() async {
  // wait 表达式使执行暂停
  var order = await fetchUserOrder();
  return 'Your order is: $order';
}

// 耗时函数
Future<String> fetchUserOrder() =>
    // Imagine that this function is
// more complex and slow.
    Future.delayed(
      const Duration(seconds: 5),
      () => 'Large Latte',
    );

// 这是正常的代码, await关键字仅在函数体前面定义的async函数中有效。
Future<void> main() async {
  print('Fetching user order...');
  var s = await createOrderMessage(); // 隐式将Future<String> 转换成 String
  print(s); // 等待异步函数执行完成，下面的代码才会打印
  print('Fetching user order finished');

  /**
   *  fetching user order...
      Your order is: Large Latte  5秒之后才打印
      Fetching user order finished
   */
}
