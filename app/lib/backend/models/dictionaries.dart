import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kana/kana.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:shared_models/shared_models.dart';
import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/utils/utils.dart';

export 'package:shared_models/shared_models.dart';

@immutable
class Dictionaries {
  const Dictionaries({
    @required this.japanese,
  });

  final Dictionary japanese;

  List<Dictionary> get all => [japanese];

  List<Language> get supportedLanguages {
    return all.map((dict) => dict.language).toList();
  }

  static Dictionaries of(BuildContext context) {
    return Provider.of<Dictionaries>(context, listen: false);
  }

  static Future<Dictionary> _loadDictionaryFromDisk(Language language) async {
    final dictText = await rootBundle.loadString(dictionaryFiles[language]);
    final dictJson = json.decode(dictText) as Map<String, dynamic>;

    final dict = Dictionary.fromJson(dictJson);

    return dict;
  }

  static Future<Dictionaries> loadFromDisk() async {
    final japanese = await _loadDictionaryFromDisk(Language.japanese);

    return Dictionaries(
      japanese: japanese,
    );
  }
}

extension DictionaryX on Dictionary {
  static Dictionary of(BuildContext context) {
    return Provider.of<Dictionary>(context, listen: false);
  }
}

extension WordEntryX on WordEntry {
  String get mostSuitableSpelling {
    return phoneticSpellings.firstWhere(
      (spelling) => spelling.chars.every(isCharHiragana),
      orElse: () => throw StateError(
        'Phonetic spellings ($phoneticSpellings) '
        'does not contain a full hiragana version',
      ),
    );
  }
}
