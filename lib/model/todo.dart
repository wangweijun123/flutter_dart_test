class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);

  @override
  String toString() {
    // TODO: implement toString
    return '[title=$title, description=$description]';
  }
}
