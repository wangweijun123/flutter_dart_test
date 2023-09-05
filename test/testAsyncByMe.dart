
// 耗时函数
Future<String> fetchRole(int id) {
  // 第一种写法
  // return Future.delayed(const Duration(seconds: 2),
  //         ()=> throw 'can not fetch role'
  // );

  //  第二种写法
  return Future.delayed(const Duration(seconds: 2),
          () {
            if (id == 0) {
              throw 'can not fetch role';
            } else {
              return "tester";
            }
          }
  );
}


// async  await关键词 避免回调地狱
Future<String> reportUserRole(int id) async {
  try {
    // role 类型是字符窜
    var role = await fetchRole(id);
    var result = "User role: $role";
    // print("result = $result");
    return result;
  } catch (err) {
    return err.toString();
  }
  
}

Future<void> main() async {
  var s = await reportUserRole(0);
  print("s = $s");
}

