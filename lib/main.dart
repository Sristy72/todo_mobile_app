import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/screen/home_screen.dart';


void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
