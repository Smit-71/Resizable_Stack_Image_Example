import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:resizable_stack_image/src/resizable_stack_image.dart';
import 'package:resize_stack_image_example/resizable_stack_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Resizable Stack Image",
          ),
          actions: [
            Visibility(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _pickedImage = null;
                  });
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
        body: Center(
          child: _pickedImage != null
              ? Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset(
                        "assets/image.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    ResizableStackImage(
                      height: 300,
                      width: 300,
                      child: Image.file(_pickedImage!),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
        ),
      ),
    );
  }
}
