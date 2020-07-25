import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shiritori/backend/backend.dart';

/// A data class that represents a guess made by a player (or CPU) while playing
/// a [Game].
class Guess extends Equatable {
  const Guess({
    @required this.query,
    @required this.validity,
    @required this.entry,
  })  : assert(query != null),
        assert(validity != null),
        assert(validity == GuessValidity.doesNotExist || entry != null);

  /// The raw string of the guess after calling [Language.mapToLanguage] on it.
  ///
  /// If a corresponding [WordEntry] exists, it is set to [entry].
  ///
  /// Cannot be `null`.
  final String query;

  /// The validity of the guess.
  ///
  /// Cannot be `null`.
  final GuessValidity validity;

  /// The entry corresponding to the [query].
  ///
  /// Cannot be `null` unless [validity] is [GuessValidity.doesNotExist], in
  /// which case this field must be `null`.
  final WordEntry entry;

  bool get isValid => validity.isValid;
  bool get isInvalid => validity.isInvalid;

  /// Indicates if [entry] is not `null`.
  bool get wordExists => entry != null;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [query, validity, entry];
}
