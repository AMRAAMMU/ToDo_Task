import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/screens/notes_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: NotesScreen(),
    );
  }
}
