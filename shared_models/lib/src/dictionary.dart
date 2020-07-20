import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:shared_models/shared_models.dart';

part 'dictionary.g.dart';

@immutable
@JsonSerializable()
class Dictionary extends Equatable {
  const Dictionary({
    @required this.language,
    @required this.indicies,
    @required this.entries,
  });

  factory Dictionary.fromEntries({
    @required Language language,
    @required List<WordEntry> entries,
  }) {
    assert(language != null);
    assert(entries != null);

    final indicies = <String, Set<int>>{};

    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      final entryKeys = [
        ...entry.spellings,
        ...entry.phoneticSpellings,
      ];

      for (final entryKey in entryKeys) {
        if (indicies[entryKey] == null) {
          indicies[entryKey] = {};
        }
        indicies[entryKey].add(index);
      }
    }

    return Dictionary(
      language: language,
      indicies: indicies,
      entries: entries,
    );
  }

  final Language language;
  final Map<String, Set<int>> indicies;
  final List<WordEntry> entries;

  factory Dictionary.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFromJson(json);
  Map<String, dynamic> toJson() => _$DictionaryToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [indicies, entries];
}
