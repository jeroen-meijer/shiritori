// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dictionary _$DictionaryFromJson(Map<String, dynamic> json) {
  return Dictionary(
    language: json['language'] == null
        ? null
        : Language.fromJson(json['language'] as Map<String, dynamic>),
    indicies: (json['indicies'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as int)?.toSet()),
    ),
    entries: (json['entries'] as List)
        ?.map((e) =>
            e == null ? null : WordEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DictionaryToJson(Dictionary instance) =>
    <String, dynamic>{
      'language': instance.language?.toJson(),
      'indicies': instance.indicies?.map((k, e) => MapEntry(k, e?.toList())),
      'entries': instance.entries?.map((e) => e?.toJson())?.toList(),
    };
