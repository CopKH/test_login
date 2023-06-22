import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'package:image_picker/image_picker.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final _imageKey = GlobalKey<ImagePainterState>();
  @override
  void initState() {
    getImage(ImageSource.camera);
    super.initState();
  }

  File? _imageFile;
  String? _imagePath = '';
  final picker = ImagePicker();

  Future getImage(source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  void saveImage() async {
    // print('saveImage');
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File('$fullPath');
    // print('image');
    // print(image as List<int>);
    // imgFile.writeAsBytesSync(image as List<int>);
    // await ImageGallerySaver.saveImage(image!);
    final result = await ImageGallerySaver.saveImage(image!);
    print('Image saved to gallery: $result');

    // imgFile.writeAsBytesSync(image as List<int>);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Image Exported successfully.",
                  style: TextStyle(color: Colors.white)),
              // TextButton(
              //   onPressed: () => OpenFile.open("$fullPath"),
              //   child: Text(
              //     "Open",
              //     style: TextStyle(
              //       color: Colors.blue[200],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imagePath != '')
              ImagePainter.file(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                _imageFile!,
                key: _imageKey,
                scalable: true,
                initialStrokeWidth: 2,
                // textDelegate: DutchTextDelegate(),
                initialColor: Colors.green,
                initialPaintMode: PaintMode.line,
              ),
            ElevatedButton(
                onPressed: saveImage, child: const Text('Save Image'))
          ],
        ),
      ),
    );
  }
}
