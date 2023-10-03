//定义商品Item类
class Item {
  double price;
  String name;

  Item(this.name, this.price);
}

//定义购物车类
class ShoppingCart {
  // 用户名
  String name;
  late DateTime date;

  // 优惠码
  String code;
  late List<Item> bookings;

  ShoppingCart(this.name, this.code) {
    date = DateTime.now();
  }

  // 购物车价格, 注意不一定需要写返回值，智能推断
  price() {
    double sum = 0;
    for (var item in bookings) {
      sum += item.price;
    }
    return sum;
  }

  getInfo() {
    return '购物车信息:' +
        '\n-----------------------------' +
        '\n用户名: ' +
        name +
        '\n优惠码: ' +
        code +
        '\n总价: ' +
        price().toString() +
        '\n日期: ' +
        date.toString() +
        '\n-----------------------------';
  }
}

void main() {
  ShoppingCart sc = ShoppingCart('张三', '123456');
  sc.bookings = [Item('苹果', 10.0), Item('鸭梨', 20.0)];
  print(sc.getInfo());
}
