import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;

  int _time = 0;
  bool _isRunning = false;

  final List<String> _lapTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _time = 0;
    _lapTimes.clear();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _recordLapTime(String time) {
    _lapTimes.insert(0, time);
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String millisec = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: const TextStyle(fontSize: 50),
              ),
              Text(millisec),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 100,
            height: 100,
            child: ListView(
              children: _lapTimes.map((e) => Center(child: Text(e))).toList(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                backgroundColor: Colors.lime,
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$millisec');
                  });
                },
                backgroundColor: Colors.lime,
                child: const Icon(Icons.pause),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
