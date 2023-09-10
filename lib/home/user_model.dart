class User {
  String name, last;
  int age;
  User({required this.name, required this.last, required this.age});

  @override
  String toString() => '$name $last, $age years old';
}
