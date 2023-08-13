import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/models/counter.dart';
import 'package:mocktail/mocktail.dart';

class CounterMock extends Mock implements Counter {}

void main() {
  late CounterMock counter;

  setUp(() {
    counter = CounterMock();
  });

  group('counter test', () {
    test("test counter remark 2", () async {
      when(() => counter.setRemark()).thenReturn("1 counts");
      counter.increment();
      final remark = counter.setRemark();
      expect(remark, "1 counts");
    });

    test("test counter remark 2", () async {
      when(() => counter.setRemark()).thenReturn("2 counts");
      counter.increment();
      counter.increment();
      final remark = counter.setRemark();
      expect(remark, "2 counts");
    });
  });
}
