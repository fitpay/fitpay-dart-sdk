import 'package:fitpay_dart_sdk/fitpay.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    API api;

    setUp(() async {
      api = await initializeApiWithFirebaseToken("test", "test");
    });

    test('First Test', () {});
  });
}
