// 全局变量当然能被引用的地方使用
const num = 100;

void gloabMethod() {
  print('');
}

//
void _gloabMethod2() {
  print('');
}

class ClassInC {
  int a = 0;

  int _b = 100;
}
