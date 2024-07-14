import 'package:flutter/material.dart';
import 'package:flutter_project/bmi_calculator/result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    save();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    if (height != null && weight != null) {
      _heightController.text = height.toString();
      _weightController.text = weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height',
                ),
                keyboardType: TextInputType.number,
                validator: (height) {
                  if (height == null || height.isEmpty) {
                    return 'Enter your height';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Weight',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (weight) {
                    if (weight == null || weight.isEmpty) {
                      return 'Enter your weight';
                    } else {
                      return null;
                    }
                  }),
              ElevatedButton(
                onPressed: () {
                  save();
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          height: double.parse(_heightController.text),
                          weight: double.parse(_weightController.text),
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
