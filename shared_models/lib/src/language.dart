import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'language.g.dart';

@immutable
@JsonSerializable()
class Language extends Equatable {
  const Language(this.code, this.name);

  final String code;
  final String name;

  static const english = Language('en', 'English');
  static const japanese = Language('ja', '日本語');

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, name];
}
