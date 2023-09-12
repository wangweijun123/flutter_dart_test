import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/task_data.dart';
import 'screens/tasks_screen.dart';

void main() => runApp(MyAppDateProvider());
var data = TaskData();

class MyAppDateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => data,
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
