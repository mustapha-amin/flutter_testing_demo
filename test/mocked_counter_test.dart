import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/models/counter.dart';
import 'package:mocktail/mocktail.dart';

class MockCounter extends Mock implements Counter {}

// ignore: slash_for_doc_comments
/**
 * HOW TO MOCK
 * 
 * when(() => fn) - Arrange
 * fn() - Act
 * verify(() => fn) - Assert
 */

void main() {
  late MockCounter mockCounter;

  setUp(() {
    mockCounter = MockCounter();
  });

  test("Count initial state", () {
    when(() => mockCounter.count).thenReturn(0);
    expect(mockCounter.count, 0);
  });

  test("Count mutations", () {
    when(() => mockCounter.increment()).thenAnswer((_) {
      mockCounter.count++;
    });
    when(() => mockCounter.count).thenReturn(2);

    mockCounter.increment();
    mockCounter.increment();
    verify(() => mockCounter.increment()).called(2);

    expect(mockCounter.count, 2);

    mockCounter.decrement();
    verify(() => mockCounter.decrement()).called(1);
    when(() => mockCounter.count).thenReturn(1);

    expect(mockCounter.count, 1);
  });

  test("Test exceptions", () {
    when(() => mockCounter.count).thenReturn(0);
    expect(mockCounter.count, 0);

    when(() => mockCounter.decrement()).thenAnswer((_) => mockCounter.count--);
    mockCounter.decrement();
    verify(() => mockCounter.decrement()).called(1);

    //* mockCounter.decrement();
    //* verify(() => mockCounter.decrement()).called(1);
    
    //* expect(mockCounter.count, 0);
  });
}
