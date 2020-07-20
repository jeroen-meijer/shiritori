import 'dart:async';
import 'dart:math';

import 'package:meta/meta.dart';

// Typedefs
typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef FutureValueChanged<T> = FutureOr<void> Function(T value);
typedef ValueBuilder<T> = T Function();
typedef Mapper<T, R> = R Function(T value);
typedef IndexValueChanged<T> = void Function(int index, T value);

// Functions
Mapper<T, T> id<T>() => (value) => value;
Mapper<dynamic, T> castDynamic<T>() => (value) => value as T;

// Classes
class Tuple<T1, T2> {
  const Tuple(this.left, this.right);

  final T1 left;
  final T2 right;
}

// Extensions
extension TupleListUtils<T1, T2> on List<Tuple<T1, T2>> {
  List<T1> get allLefts => map((t) => t.left).toList();
  List<T2> get allRights => map((t) => t.right).toList();
}

extension NumUtils on num {
  int roundToNearest(int rounding) {
    return (this / rounding).round() * rounding;
  }

  String _getStringPadding({
    @required int amount,
    String paddingCharacter = '0',
  }) {
    final padAmount = amount - toString().length;
    return paddingCharacter * (padAmount < 0 ? 0 : padAmount);
  }

  String padLeft({
    @required int amount,
    String paddingCharacter = '0',
  }) {
    return _getStringPadding(
            amount: amount, paddingCharacter: paddingCharacter) +
        toString();
  }

  String padRight({
    @required int amount,
    String paddingCharacter = '0',
  }) {
    return toString() +
        _getStringPadding(amount: amount, paddingCharacter: paddingCharacter);
  }
}

extension IterableUtils<T> on Iterable<T> {
  T get firstOrNull => isEmpty ? null : first;

  T get lastOrNull => isEmpty ? null : last;

  bool containsAny(Iterable<T> candidates) {
    if (candidates.isEmpty) {
      return false;
    }

    return contains(candidates.first) || containsAny(candidates.skip(1));
  }

  Stream<void> asyncForEach(Future<void> Function(T element) f) async* {
    for (final element in this) {
      yield f(element);
    }
  }

  Stream<R> asyncMap<R>(FutureOr<R> Function(T element) convert) async* {
    for (final element in this) {
      yield await convert(element);
    }
  }

  Iterable<T> whereOrEmpty(bool Function(T element) test) {
    try {
      return where(test);
      // ignore: avoid_catching_errors
    } on StateError {
      return <T>[];
    }
  }

  T firstWhereOrNull(bool Function(T element) test) {
    return firstWhere(test, orElse: () => null);
  }

  Iterable<T> intersperse(T element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }
}

extension ListUtils<T> on List<T> {
  T elementOrNullAt(int index) {
    if (asMap().containsKey(index)) {
      return elementAt(index);
    }

    return null;
  }

  T get random {
    return elementAt(Random().nextInt(length));
  }
}

extension StringUtils on String {
  /// Divides this [String] into two parts.
  ///
  /// The first part contains all the characters string from index `0` until
  /// [index] (exclusively). The seconds part contains the remaining characters.
  ///
  /// This means an [index] of `0` will return a [Tuple] with an empty string
  /// on the `left` and the entire string on the `right`.
  /// An [index] of the length of this [String] will return a [Tuple] with the
  /// entire string on the `left` and an empty string on the `right`.
  Tuple<String, String> divide(int index) {
    assert(index >= 0 && index <= length);

    return Tuple(
      chars.sublist(0, index).join(),
      chars.sublist(index).join(),
    );
  }

  /// Divides this [String] into two parts with the entire string except for the
  /// last character on the `left` and the last character on the `right`.
  Tuple<String, String> chipOffLast() {
    return divide(length - 1);
  }

  List<String> get chars => split('');

  String get reversed => chars.reversed.join();

  bool containsAny(Iterable<String> candidates) {
    if (candidates.isEmpty) {
      return false;
    }

    return contains(candidates.first) || containsAny(candidates.skip(1));
  }
}
