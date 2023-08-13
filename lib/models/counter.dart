class Counter {
  int count = 0;
  String remark = '';



  void increment() => count++;

  void decrement() => count--;

  String setRemark() {
    remark = count == 1 ? '$count count' : '$count counts';
    return remark;
  }
}
