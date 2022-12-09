import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/core/utils/string_extension.dart';

void main() {
  group('String extension tests', () {

    test('is a valid email', () {
      final email = 'angga@gmail.com';

      expect(email.isValidEmail, true);
    });

    test('is not a valid email', () {
      final email = 'angga.....mail....';

      expect(email.isValidEmail, false);
    });

  });
}


