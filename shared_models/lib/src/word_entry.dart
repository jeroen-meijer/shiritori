import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'word_entry.g.dart';

@immutable
@JsonSerializable()
class WordEntry extends Equatable {
  const WordEntry({
    @required final List<String> spellings,
    @required final List<String> phoneticSpellings,
    @required final List<String> definitions,
  })  : spellings = spellings ?? const [],
        phoneticSpellings = phoneticSpellings ?? const [],
        definitions = definitions ?? const [];

  /// In Japanese: Kanji spellings. May be empty.
  final List<String> spellings;

  /// In Japanese: Kana spellings.
  ///
  /// Is guaranteed to not be empty and contain at least a single full Hiragana
  /// version.
  final List<String> phoneticSpellings;

  /// A list of definitions for this word.
  final List<String> definitions;

  List<String> get allSpellings => [
        ...spellings,
        ...phoneticSpellings,
      ];

  factory WordEntry.fromJson(Map<String, dynamic> json) =>
      _$WordEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WordEntryToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [spellings, phoneticSpellings, definitions];
}
