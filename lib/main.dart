import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        "/home":(context) => HomeScreen(),
      },
    );
  }
}