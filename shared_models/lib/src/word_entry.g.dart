// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordEntry _$WordEntryFromJson(Map<String, dynamic> json) {
  return WordEntry(
    spellings: (json['spellings'] as List)?.map((e) => e as String)?.toList(),
    phoneticSpellings:
        (json['phonetic_spellings'] as List)?.map((e) => e as String)?.toList(),
    definitions:
        (json['definitions'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$WordEntryToJson(WordEntry instance) => <String, dynamic>{
      'spellings': instance.spellings,
      'phonetic_spellings': instance.phoneticSpellings,
      'definitions': instance.definitions,
    };
