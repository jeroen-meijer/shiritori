import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Language extends Equatable {
  const Language(this.code, this.name);

  final String code;
  final String name;

  static const english = Language('en', 'English');
  static const japanese = Language('ja', '日本語');

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }

  static Language fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Language(
      map['code'] as String,
      map['name'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, name];
}
