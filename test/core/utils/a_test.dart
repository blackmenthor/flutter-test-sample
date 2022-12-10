import 'package:flutter_test/flutter_test.dart';

class B {
  B({
      required this.numb,
  });
  final int numb;
  int get number {
    return numb;
  }
}

class A {
  A({
      required this.b,
  });
  final B b;

  int get result {
    return 1 + b.number;
  }
}

void main() {
  group('A tests', () {
    test('result should return correct number', () {
      final a = A(
        b: B(
          numb: 1,
        ), // NOT ENCOURAGED
      );
      expect(a.result, 2);
    });
  });
}