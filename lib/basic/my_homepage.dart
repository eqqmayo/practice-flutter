import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int _count = 0;
  String _text = '';
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Flutter App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_count',
                style: const TextStyle(
                  color: Colors.black12,
                  fontSize: 30,
                ),
              ),
              const Text(
                'Hallooo',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated Button'),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'Enter something',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (input) {
                        _text = input;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        print(_text);
                        print(_textController.text);
                        setState(() {});
                      },
                      child: const Text('Outlined Button'),
                    ),
                  ),
                ],
              ),
              Text(_textController.text),
              Container(
                color: Colors.lime,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/cat.jpeg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
