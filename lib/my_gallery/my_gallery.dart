import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({super.key});

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  final _picker = ImagePicker();
  List<XFile> images = [];
  int currentPage = 0;
  final _pageController = PageController();

  @override
  void initState() {
    loadImages();
    super.initState();
  }

  Future<void> loadImages() async {
    images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        currentPage++;

        if (currentPage == images.length) {
          currentPage = 0;
        }

        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gallery'),
      ),
      body: images.isEmpty
          ? const Center(child: Text('No Data'))
          : PageView(
              controller: _pageController,
              children: images
                  .map((image) => FutureBuilder<Uint8List>(
                      future: image.readAsBytes(),
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        if (data == null ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Image.memory(
                          data,
                          width: double.infinity,
                        );
                      }))
                  .toList(),
            ),
    );
  }
}
