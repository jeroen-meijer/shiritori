import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:shared_models/shared_models.dart';
import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/backend/backend.dart';

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

  static Dictionaries of(BuildContext context, {bool listen = true}) {
    return Provider.of<Dictionaries>(context, listen: listen);
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
