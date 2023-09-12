import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy bread'),
    Task(name: '0 bread'),
    Task(name: '1 bread'),
    Task(name: '2 bread'),
    Task(name: '3 bread'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
