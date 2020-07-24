import 'dart:developer';

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
    @required this.phoneticIndicies,
    @required this.startIndicies,
    @required this.entries,
  });

  factory Dictionary.fromEntries({
    @required Language language,
    @required List<WordEntry> entries,
  }) {
    assert(language != null);
    assert(entries != null);

    final phoneticIndicies = <String, Set<int>>{};
    final startIndicies = <String, Set<int>>{};

    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      final entryPhoneticIndicies = {
        ...entry.phoneticSpellings,
      };
      for (final entryKey in entryPhoneticIndicies) {
        if (phoneticIndicies[entryKey] == null) {
          phoneticIndicies[entryKey] = {};
        }
        phoneticIndicies[entryKey].add(index);
      }

      final entryStartIndicies = {
        for (final index in entryPhoneticIndicies)
          language.selectStartingCharacter(index),
      };
      for (final entryKey in entryStartIndicies) {
        if (startIndicies[entryKey] == null) {
          startIndicies[entryKey] = {};
        }
        startIndicies[entryKey].add(index);
      }
    }

    return Dictionary(
      language: language,
      phoneticIndicies: phoneticIndicies,
      startIndicies: startIndicies,
      entries: entries,
    );
  }

  final Language language;

  /// A [Map] that maps phonetic spellings of word entries to a list of entries
  /// that contain that phonetic spelling.
  ///
  /// ```dart
  /// // Entries
  /// [
  ///   'apple (a fruit)',
  ///   'apple (a tech company)',
  ///   'break (a mechanism for stopping a vehicle)',
  ///   'break (a time of resting during work)',
  /// ]
  /// // Word indicies
  /// {
  ///   'apple': [0, 1],
  ///   'break': [2, 3],
  /// }
  /// ```
  final Map<String, Set<int>> phoneticIndicies;

  /// A [Map] that maps the starting letters of word entries to a list of
  /// entries that start with those starting.
  ///
  /// ```dart
  /// // Entries
  /// [
  ///   'apple (a fruit)',
  ///   'almond (a deciduous tree)',
  ///   'bill (an amount of money owed)',
  ///   'ball (a sphere)',
  /// ]
  /// // startToEnd indicies
  /// {
  ///   'a': [0, 1]
  ///   'b': [2, 3],
  /// }
  /// ```
  final Map<String, Set<int>> startIndicies;

  /// All word entries that [phoneticIndicies] and [startIndicies] point to.
  final List<WordEntry> entries;

  Set<WordEntry> searchWordsThatStartsWith(String query) {
    log('SEARCH START "$query"');
    final queryIndicies = startIndicies[query];
    if (queryIndicies == null) {
      return {};
    }
    return queryIndicies.map((index) => entries[index]).toSet();
  }

  Set<WordEntry> searchWords(String query) {
    log('SEARCH "$query"');
    final queryIndicies = phoneticIndicies[query];
    if (queryIndicies == null) {
      return {};
    }

    return queryIndicies.map((index) => entries[index]).toSet();
  }

  factory Dictionary.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFromJson(json);
  Map<String, dynamic> toJson() => _$DictionaryToJson(this);

  @override
  String toString() {
    return 'Dictionary for language ${language.code} '
        '(${phoneticIndicies.length} indicies, ${entries.length} entries)';
  }

  @override
  List<Object> get props => [phoneticIndicies, entries];
}
