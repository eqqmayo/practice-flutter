import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TiltSensor extends StatelessWidget {
  const TiltSensor({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
              stream: accelerometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Positioned(
                  left: centerX + snapshot.data!.y * 20,
                  top: centerY + snapshot.data!.x * 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    width: 100,
                    height: 100,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
