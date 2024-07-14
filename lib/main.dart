import 'package:flutter/material.dart';
import 'package:flutter_project/stop_watch/stop_watch_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: false,
      ),
      home: const StopWatchScreen(),
    );
  }
}
