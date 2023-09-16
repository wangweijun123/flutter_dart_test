//声明了一个延迟3秒返回Hello的Future，并注册了一个then返回拼接后的Hello 2019
Future<String> fetchContent() =>
    Future<String>.delayed(Duration(seconds: 3), () => "Hello")
        .then((x) => "$x 2019");

main() async {
  print(await fetchContent()); //等待Hello 2019的返回
}
