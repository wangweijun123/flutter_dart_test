//声明了一个延迟2秒返回Hello的Future，并注册了一个then返回拼接后的Hello 2019
Future<String> fetchContent() =>
    Future<String>.delayed(Duration(seconds: 2), () => "Hello")
        .then((x) => "$x 2019");
//异步函数会同步等待Hello 2019的返回，并打印
func() async => print(await fetchContent());

// 最终输出的顺序其实是“func before”“func after”“Hello 2019, 这是命令行，所以程序退出了,没有打印 Hello 2019
main() {
  print("func before");
  func();
  print("func after");
}
