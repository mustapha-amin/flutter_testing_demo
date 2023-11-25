class Counter {
  int count = 0;
  String remark = '';

  void increment() => count++;

  void decrement() => count > 0 ? count-- : throw CounterException;

  void setRemark() {
    remark = count == 1 ? '$count count' : '$count counts';
  }
}

class CounterException implements Exception {
  const CounterException();

  @override
  toString() {
    return "Can't go beyond zero";
  }
}