// test/shooting_provider_test.dart
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:mockito/mockito.dart';

import '../lib/providers/shooting_provider.dart';

class MockPathProviderPlatform extends Mock implements PathProviderPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  
  MockPathProviderPlatform mockPathProviderPlatform = MockPathProviderPlatform();
  PathProviderPlatform.instance = mockPathProviderPlatform;
  when(mockPathProviderPlatform.getApplicationDocumentsPath()).thenAnswer((_) async => '.');

  group('ShootingProvider Tests', () {
    late ShootingProvider provider;

    setUp(() {
      provider = ShootingProvider();
    });

    test('Initial parameters should be correct', () {
      expect(provider.params.plantNumber, 0);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, true);
      expect(provider.params.beforeDrop, true);
    });

    test('Save and advance when nextPlant is true and beforeDrop is true', () async {
      await provider.saveAndAdvance(Uint8List(0));
      expect(provider.params.plantNumber, 1);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, true);
      expect(provider.params.beforeDrop, true);
    });

    test('Save and advance when nextPlant is true and beforeDrop is false', () async {
      provider.setBeforeDrop(false);
      await provider.saveAndAdvance(Uint8List(0));
      expect(provider.params.plantNumber, 1);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, true);
      expect(provider.params.beforeDrop, true);
    });

    test('Save and advance when nextPlant is false and beforeDrop is true', () async {
      provider.setNextPlant(false);
      await provider.saveAndAdvance(Uint8List(0));
      expect(provider.params.plantNumber, 0);
      expect(provider.params.beforeDropNumber, 1);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, false);
      expect(provider.params.beforeDrop, true);
    });

    test('Save and advance when nextPlant is false and beforeDrop is false', () async {
      provider.setNextPlant(false);
      provider.setBeforeDrop(false);
      await provider.saveAndAdvance(Uint8List(0));
      expect(provider.params.plantNumber, 0);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 1);
      expect(provider.params.nextPlant, false);
      expect(provider.params.beforeDrop, true);
    });

    test('Discard and advance when nextPlant is true and beforeDrop is true', () {
      provider.discardAndAdvance();
      expect(provider.params.plantNumber, 1);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, true);
      expect(provider.params.beforeDrop, true);
    });

    test('Discard and advance when nextPlant is true and beforeDrop is false', () {
      provider.setBeforeDrop(false);
      provider.discardAndAdvance();
      expect(provider.params.plantNumber, 1);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, true);
      expect(provider.params.beforeDrop, true);
    });

    test('Discard and advance when nextPlant is false and beforeDrop is true', () {
      provider.setNextPlant(false);
      provider.discardAndAdvance();
      expect(provider.params.plantNumber, 0);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, false);
      expect(provider.params.beforeDrop, true);
    });

    test('Discard and advance when nextPlant is false and beforeDrop is false', () {
      provider.setNextPlant(false);
      provider.setBeforeDrop(false);
      provider.discardAndAdvance();
      expect(provider.params.plantNumber, 0);
      expect(provider.params.beforeDropNumber, 0);
      expect(provider.params.afterDropNumber, 0);
      expect(provider.params.nextPlant, false);
      expect(provider.params.beforeDrop, true);
    });

    test('File name generation', () {
      provider.setNextPlant(false);
      provider.setBeforeDrop(true);
      expect(provider.params.getFileName(), 'before_0_0');
      
      provider.setBeforeDrop(false);
      expect(provider.params.getFileName(), 'after_0_0');
      
      provider.setNextPlant(true);
      provider.setBeforeDrop(true);
      expect(provider.params.getFileName(), 'before_0_0');
    });
  });
}
