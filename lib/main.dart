import 'package:flutter/material.dart';
import 'package:flutter_project/xylophone/xylophone.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: false,
      ),
      home: const Xylophone(),
    );
  }
}
