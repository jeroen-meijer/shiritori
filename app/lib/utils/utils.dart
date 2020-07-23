import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';

// Typedefs
typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef FutureValueChanged<T> = FutureOr<void> Function(T value);
typedef ValueBuilder<T> = T Function();
typedef Mapper<T, R> = R Function(T value);
typedef IndexValueChanged<T> = void Function(int index, T value);

// Functions
Mapper<T, T> id<T>() => (value) => value;
Mapper<dynamic, T> castDynamic<T>() => (value) => value as T;

/// {@template tuple}
/// A data class that contains two elements ([left] and [right]).
/// {@endtemplate}
class Tuple<T1, T2> extends Equatable {
  /// {@macro tuple}
  const Tuple(this.left, this.right);

  /// The first element.
  final T1 left;

  /// The second element.
  final T2 right;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [left, right];
}

/// Extensions that make handling collections of [Tuple]s more convenient.
extension TupleIterableUtils<T1, T2> on Iterable<Tuple<T1, T2>> {
  /// Returns a new [Iterator<T1>] that contains all `left` elements.
  Iterable<T1> get allLefts => map((t) => t.left);

  /// Returns a new [Iterator<T2>] that contains all `right` elements.
  Iterable<T2> get allRights => map((t) => t.right);
}

/// Extensions that make handling collections of [num]s more convenient.
extension NumUtils on num {
  /// Rounds this [num] to the nearest [rounding].
  ///
  /// When rounding can go both up or down, rounding up is preferred.
  ///
  /// ```dart
  /// 1.roundToNearest(5); // 0
  /// 2.roundToNearest(5); // 0
  /// 3.roundToNearest(5); // 5
  /// 4.roundToNearest(5); // 5
  ///
  /// 13.roundToNearest(2); // 14
  /// ```
  int roundToNearest(int rounding) {
    return (this / rounding).round() * rounding;
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

/// Extensions that make handling [List]s more convenient.
extension ListUtils<T> on List<T> {
  /// Gets the element at [index]. If no element exists, returns `null` instead.
  T elementOrNullAt(int index) {
    return asMap()[index];
  }

  /// Gets a random element from this [List].
  T get random {
    return elementAt(Random().nextInt(length));
  }
}

/// Extensions that make handling [String]s more convenient.
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

  /// Returns a list of every character in this `String`.
  List<String> get chars => split('');

  /// Returns the reverse of this string.
  ///
  /// ```dart
  /// "Hello".reversed; // "olleH"
  /// ```
  String get reversed => chars.reversed.join();

  /// The code unit for the first character in this `String`.
  ///
  /// Shorthand for [codeUnitAt(0)].
  int get code {
    return codeUnitAt(0);
  }

  /// Indicates if this entire `String` only contains uppercase letters.
  bool get isUpperCase {
    return this == toUpperCase();
  }

  /// Indicates if this entire `String` only contains lowercase letters.
  bool get isLowerCase {
    return this == toLowerCase();
  }

  /// Returns `true` if this string contains any of the [candidates].
  bool containsAny(Iterable<String> candidates) {
    if (candidates.isEmpty) {
      return false;
    }

    return contains(candidates.first) || containsAny(candidates.skip(1));
  }
}
