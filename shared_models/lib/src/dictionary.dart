import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:shared_models/shared_models.dart';

@immutable
class Dictionary extends Equatable {
  const Dictionary._({
    @required this.indicies,
    @required this.entries,
  });

  factory Dictionary.fromEntries({
    @required Language language,
    @required List<WordEntry> entries,
  }) {
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

    return Dictionary._(
      indicies: indicies,
      entries: entries,
    );
  }

  final Map<String, Set<int>> indicies;
  final List<WordEntry> entries;

  Map<String, dynamic> toJson() {
    return {
      'indicies': indicies.map((key, indicies) {
        return MapEntry<String, List<int>>(
          key,
          indicies.toList(growable: false),
        );
      }),
      'entries': entries?.map((x) => x?.toJson())?.toList(),
    };
  }

  static Dictionary fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return Dictionary._(
      indicies: Map<String, Set<int>>.from(
        map['indicies'] as Map<String, Set<int>>,
      ),
      entries: List<WordEntry>.from(
        (map['entries'] as List<Map<String, dynamic>>)?.map(WordEntry.fromJson),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [indicies, entries];
}
