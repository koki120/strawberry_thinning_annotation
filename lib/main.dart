// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/shooting_provider.dart';
import 'screens/parameter_screen.dart';
import 'screens/camera_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShootingProvider(),
      child: MaterialApp(
        title: '滴下アノテーションソフト',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ParameterScreen(),
          '/camera': (context) => CameraScreen(),
        },
      ),
    );
  }
}
