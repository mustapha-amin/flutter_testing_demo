import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/models/counter.dart';

void main() {
  late Counter counter;

  setUp(() {
    counter = Counter();
  });

  test("Test the counter", () async {
    counter.increment();
    counter.increment();
    expect(counter.count, 2);
  });
}
