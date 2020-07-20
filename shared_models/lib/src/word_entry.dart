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

  final List<String> spellings;
  final List<String> phoneticSpellings;
  final List<String> definitions;

  factory WordEntry.fromJson(Map<String, dynamic> json) =>
      _$WordEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WordEntryToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [spellings, phoneticSpellings, definitions];
}
