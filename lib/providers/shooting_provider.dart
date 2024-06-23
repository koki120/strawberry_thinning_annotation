// lib/providers/shooting_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/shooting_parameters.dart';

class ShootingProvider with ChangeNotifier {
  ShootingParameters _params = ShootingParameters();

  ShootingProvider() {
    _loadParameters();
  }

  ShootingParameters get params => _params;

  Future<void> saveAndAdvance(Uint8List imageData) async {
    String fileName = _params.getFileName();
    await _saveImage(imageData, fileName);
    _params.saveAndAdvance();
    _params.reset();
    _saveParameters();
    notifyListeners();
  }

  void discardAndAdvance() {
    _params.discardAndAdvance();
    _params.reset();
    _saveParameters();
    notifyListeners();
  }

  void setNextPlant(bool value) {
    _params.nextPlant = value;
    notifyListeners();
  }

  void setBeforeDrop(bool value) {
    _params.beforeDrop = value;
    notifyListeners();
  }

  Future<void> _saveParameters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('plantNumber', _params.plantNumber);
    await prefs.setInt('beforeDropNumber', _params.beforeDropNumber);
    await prefs.setInt('afterDropNumber', _params.afterDropNumber);
    await prefs.setBool('nextPlant', _params.nextPlant);
    await prefs.setBool('beforeDrop', _params.beforeDrop);
  }

  Future<void> _loadParameters() async {
    final prefs = await SharedPreferences.getInstance();
    _params.plantNumber = prefs.getInt('plantNumber') ?? 0;
    _params.beforeDropNumber = prefs.getInt('beforeDropNumber') ?? 0;
    _params.afterDropNumber = prefs.getInt('afterDropNumber') ?? 0;
    _params.nextPlant = prefs.getBool('nextPlant') ?? true;
    _params.beforeDrop = prefs.getBool('beforeDrop') ?? true;
    notifyListeners();
  }

  Future<void> _saveImage(Uint8List imageData, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName.png';
    final file = File(path);
    await file.writeAsBytes(imageData);
    print('Image saved to $path'); // 保存先をログに表示
  }
}
