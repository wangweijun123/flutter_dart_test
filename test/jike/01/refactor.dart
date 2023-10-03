mixin PrintHelper {
  printInfo() => print(getInfo());
  getInfo();
}

class Meta {
  double price;
  String name;
//成员变量初始化语法糖
  Meta(this.name, this.price);
}

//定义商品Item类, 注意name是父class Meta 的属性，在Item中不能使用this.name
class Item extends Meta {
  // 商品数量属性；
  int account;

  Item(name, price, this.account) : super(name, price);

  //重载了+运算符，合并商品为套餐商品
  Item operator +(Item item) =>
      Item(name + item.name, price + item.price, account + item.account);

  @override
  String toString() {
    return '{ 商品名称 = $name, 数量 = $account, 单价 = $price}';
  }
}

//定义购物车类,
// with表示以非继承的方式复用了另一个类的成员变量及函数
class ShoppingCart extends Meta with PrintHelper {
  // 用户名
  late DateTime date;

  // 优惠码(不一定有)
  String? code;
  late List<Item> bookings;

  //withCode初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({name, this.code})
      : date = DateTime.now(),
        super(name, 0);

  // date, code, bookdings 本类中的属性, 这个构造函数需要写到withCode构造之后才能有提示
  ShoppingCart({userName}) : this.withCode(name: userName, code: null);

  // 购物车价格, 注意不一定需要写返回值，智能推断
  @override
  double get price {
    return bookings.reduce((value, element) => value + element).price;
  }

  getItemInfo() {
    var list = bookings.map((e) => e.toString());
    return list.toString();
  }

  @override
  getInfo() => '''
      购物车信息:
      -----------------------------
        用户名: $name
        优惠码: ${code ?? "没有"}
        
         ----------------
     商品名    单价    数量    总价
    
        ${getItemInfo()}
         ----------------
        总价: $price
        Date: $date
      -----------------------------
      ''';
}

void main() {
  ShoppingCart sc = ShoppingCart.withCode(name: '张三', code: '123456')
    ..bookings = [Item('苹果', 10.0, 1), Item('鸭梨', 20.0, 2)]
    ..printInfo();

  ShoppingCart sc2 = ShoppingCart(userName: '李四');
  sc2.bookings = [Item('香蕉', 15.0, 1), Item('西瓜', 40.0, 2)];
  sc2.printInfo();
}
