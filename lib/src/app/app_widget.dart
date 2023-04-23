import 'package:flutter/material.dart';
import 'package:todo_list/src/auth/login.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do List",
      theme: ThemeData.light(),
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}
