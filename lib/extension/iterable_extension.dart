extension IterableExtension<T> on Iterable<T> {
  int sum(int Function(T element) f) {
    int sum = 0;
    for (var element in this) {
      sum += f(element);
    }
    return sum;
  }

  T? firstOrNull(bool Function(T element) test) {
    late T result;
    if (isEmpty) return null;
    var isMatching = false;

    doObverse((index, element) {
      if (test(element)) {
        result = element;
        isMatching = true;
        return true;
      }
      return false;
    });

    if (isMatching) return result;
    return null;
  }

  T? lastOrNull(bool Function(T element) test) {
    late T result;
    if (isEmpty) return null;
    var isMatching = false;

    doReverse((index, element) {
      if (test(element)) {
        result = element;
        isMatching = true;
        return true;
      }
      return false;
    });

    if (isMatching) return result;
    return null;
  }

  T getLast(bool Function(T element) test) {
    final result = lastOrNull(test);
    if (result != null) {
      return result;
    } else {
      throw StateError("No element");
    }
  }

  /// [test] return true to stop run foreach
  doObverse(bool Function(int index, T element) test) {
    if (isEmpty) return;

    final maxIndex = length - 1;
    for (int index = 0; index <= maxIndex; index++) {
      final result = elementAt(index);
      if (test(index, result)) {
        return;
      }
    }
  }

  /// [test] return true to stop run foreach
  doReverse(bool Function(int index, T element) test) {
    if (isEmpty) return;

    final maxIndex = length - 1;
    for (int index = maxIndex; index >= 0; index--) {
      final result = elementAt(index);
      if (test(index, result)) {
        return;
      }
    }
  }

  Iterable<T> asReverse() {
    final maxIndex = length - 1;
    return Iterable.generate(length, (index) => elementAt(maxIndex - index));
  }

  Iterable<T> whereWithIndex(bool Function(int index, T element) test) {
    final result = [];

    if (isEmpty) return Iterable.castFrom(result);

    doObverse((index, element) {
      if (test(index, element)) {
        result.add(element);
      }
      return false;
    });
    return Iterable.castFrom(result);
  }
}
