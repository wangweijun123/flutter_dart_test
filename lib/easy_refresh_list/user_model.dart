class User {
  final int id;
  final String userName;

  User(this.id, this.userName);

  @override
  String toString() {
    return 'User{id: $id, userName: $userName}';
  }
}
