import 'dart:collection';

import 'package:shiritori/backend/backend.dart';

export 'jisho_dictionary_repository.dart';
export 'models/models.dart';

abstract class DictionaryRepository {
  const DictionaryRepository();

  Future<UnmodifiableListView<Word>> findWord(String query);
}
