import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
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

  Map<String, dynamic> toJson() {
    return {
      'spellings': spellings,
      'phonetic_spellings': phoneticSpellings,
      'definitions': definitions,
    };
  }

  static WordEntry fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return WordEntry(
      spellings: List<String>.from(map['spellings'] as List<String>),
      phoneticSpellings:
          List<String>.from(map['phonetic_spellings'] as List<String>),
      definitions: List<String>.from(map['definitions'] as List<String>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [spellings, phoneticSpellings, definitions];
}
