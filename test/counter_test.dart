import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/models/counter.dart';

void main() {
  late Counter counter;

  setUp(() {
    counter = Counter();
  });

  test("Test the counter and remark", () async {
    counter.increment();
    counter.increment();
    counter.setRemark();
    expect(counter.remark, '2 counts');
    expect(counter.count, 2);
  });
}
