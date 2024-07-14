import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  const ResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  (String, Icon) _getResult(double bmi) {
    String result = 'Underweight';
    Icon icon = const Icon(Icons.sentiment_dissatisfied,
        color: Colors.orange, size: 50);

    if (bmi >= 35) {
      result = 'Severe obesity';
      icon = const Icon(Icons.sentiment_very_dissatisfied,
          color: Colors.red, size: 50);
    } else if (bmi >= 30) {
      result = 'Obesity';
      icon = const Icon(Icons.sentiment_dissatisfied,
          color: Colors.purple, size: 50);
    } else if (bmi >= 25) {
      result = 'Overweight';
      icon = const Icon(Icons.sentiment_neutral, color: Colors.pink, size: 50);
    } else if (bmi >= 18.5) {
      result = 'Normal';
      icon =
          const Icon(Icons.sentiment_satisfied, color: Colors.lime, size: 50);
    }
    return (result, icon);
  }

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100.0) * (height / 100.0));
    String result = 'Normal';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getResult(bmi).$1,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            _getResult(bmi).$2,
          ],
        ),
      ),
    );
  }
}
