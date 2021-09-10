import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sort_dart/sort_dart.dart';

void main() {
  const MethodChannel channel = MethodChannel('sort_dart');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SortDart.platformVersion, '42');
  });
}
