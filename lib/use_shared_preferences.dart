import 'package:flutter/material.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class TestSharedPreference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPreferenceUI(),
    );
  }
  
}

class SharedPreferenceUI extends StatefulWidget {
  @override
  State<SharedPreferenceUI> createState() => _SharedPreferenceUIState();
}

class _SharedPreferenceUIState extends State<SharedPreferenceUI> {
  int data = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt('counter') ?? 0;
    print("loadData counter = $counter from sp");
    setState(() {
      data = counter;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Column(
        children: [
          Text("counter = $data"),
          ElevatedButton(
                child: const Text('SharedPreferenceUI test'),
                onPressed: () {
                    _incrementCounter();
                },
              ),
        ],
      )
    );
  }

  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int result = data + 1;
    await prefs.setInt('counter', result);
    setState(() {
       print("set data = $result");
      data = result;
    
    });

  }

}