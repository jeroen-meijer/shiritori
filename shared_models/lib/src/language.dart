import 'package:equatable/equatable.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:shared_models/shared_models.dart';

part 'languages/japanese.dart';

typedef WordTransformer = String Function(String word);
typedef WordValidator = bool Function(String word);

@immutable
class Language extends Equatable {
  const Language({
    @required this.code,
    @required this.name,
    WordTransformer transform,
    WordValidator validate,
    WordTransformer selectStartingCharacter,
    WordTransformer selectEndingCharacter,
  })  : assert(code != null),
        assert(name != null),
        transform = transform ?? _defaultTransformer,
        validate = validate ?? _defaultValidator,
        selectStartingCharacter =
            selectStartingCharacter ?? _defaultStartingCharacterSelector,
        selectEndingCharacter =
            selectEndingCharacter ?? _defaultEndingCharacterSelector;

  final String code;
  final String name;
  final WordTransformer transform;
  final WordValidator validate;
  final WordTransformer selectStartingCharacter;
  final WordTransformer selectEndingCharacter;

  static String _defaultTransformer(String input) => input;
  static bool _defaultValidator(String input) => true;
  static String _defaultStartingCharacterSelector(String input) {
    return input.chars.first;
  }

  static String _defaultEndingCharacterSelector(String input) {
    return input.chars.last;
  }

  static final Language japanese = _japanese;

  static final List<Language> values = [japanese];

  factory Language.fromJson(Map<String, dynamic> json) {
    final code = json['code'] as String;
    final name = json['name'] as String;

    return values.firstWhere(
      (language) => language.code == code && language.name == name,
      orElse: () => null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, name];
}
