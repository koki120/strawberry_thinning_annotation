// lib/screens/parameter_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shooting_provider.dart';

class ParameterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('撮影パラメータの決定'),
      ),
      body: Consumer<ShootingProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('次の株を撮影するか:'),
                Switch(
                  value: provider.params.nextPlant,
                  onChanged: (value) {
                    provider.setNextPlant(value);
                  },
                ),
                SizedBox(height: 16),
                Text('滴下前の画像か:'),
                Switch(
                  value: provider.params.beforeDrop,
                  onChanged: (value) {
                    provider.setBeforeDrop(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  },
                  child: Text('保存せずに次の撮影をする'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    provider.discardAndAdvance();
                    Navigator.pushNamed(context, '/camera');
                  },
                  child: Text('保存して次の撮影をする'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
