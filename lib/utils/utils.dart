import 'dart:async';

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
  const Tuple(this.first, this.second);

  final T1 first;
  final T2 second;
}

// Extensions
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

  T get random {
    return (List<T>.from(this)..shuffle()).first;
  }

  Iterable<T> safeWhere(bool Function(T element) test) {
    try {
      return where(test);
      // ignore: avoid_catching_errors
    } on StateError {
      return <T>[];
    }
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
}

extension StringUtils on String {
  bool containsAny(Iterable<String> candidates) {
    if (candidates.isEmpty) {
      return false;
    }

    return contains(candidates.first) || containsAny(candidates.skip(1));
  }
}
