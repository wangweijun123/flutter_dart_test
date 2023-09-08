import 'package:json_annotation/json_annotation.dart';

// 注意写这个以及是文件名的名字person_model
part 'person_model.g.dart';

@JsonSerializable()
class Person {
  /// The generated code assumes these values exist in JSON.
  final String firstName, lastName;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final DateTime? dateOfBirth;

  Person({required this.firstName, required this.lastName, this.dateOfBirth});

  // 1 fromJson本身是一个构造函数, 加上factory变成了工厂方法
  factory Person.fromJson(Map<String, dynamic> map) => _$PersonFromJson(map);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String toString() {
    return 'Person{firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth}';
  }
}
