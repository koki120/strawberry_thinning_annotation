// lib/screens/camera_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // カメラパッケージの例
import '../providers/shooting_provider.dart';
import 'dart:typed_data'; // 画像データの形式として仮定

class CameraScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      Uint8List imageData = await photo.readAsBytes();
      Provider.of<ShootingProvider>(context, listen: false)
          .saveAndAdvance(imageData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('撮影画面'),
      ),
      body: Consumer<ShootingProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  provider.params.beforeDrop
                      ? Icons.arrow_back
                      : Icons.arrow_forward,
                  size: 100,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _takePicture(context),
                  child: Text('撮影完了'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
