import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Xylophone extends StatefulWidget {
  const Xylophone({super.key});

  @override
  State<Xylophone> createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  final _pool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);
  final _soundIds = [];
  bool _isLoading = true;

  @override
  void initState() {
    initSoundpool();
    super.initState();
  }

  Future<void> initSoundpool() async {
    final notes = ['do1', 're', 'mi', 'fa', 'sol', 'la', 'si'];
    for (var note in notes) {
      final soundData = await rootBundle.load('assets/$note.wav');
      final soundId = await _pool.load(soundData);
      _soundIds.add(soundId);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Xylophone'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  keyboard('C', Colors.red, 16, _soundIds[0]),
                  keyboard('D', Colors.orange, 24, _soundIds[1]),
                  keyboard('E', Colors.yellow, 32, _soundIds[2]),
                  keyboard('F', Colors.green, 40, _soundIds[3]),
                  keyboard('G', Colors.cyan, 48, _soundIds[4]),
                  keyboard('A', Colors.blue, 56, _soundIds[5]),
                  keyboard('B', Colors.purple, 64, _soundIds[6]),
                ],
              ));
  }

  Widget keyboard(String text, Color color, double padding, int soundId) {
    return GestureDetector(
      onTap: () {
        _pool.play(soundId);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Container(
          width: 50,
          height: double.infinity,
          color: color,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
