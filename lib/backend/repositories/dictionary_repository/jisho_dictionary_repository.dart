import 'dart:collection';

import 'package:shiritori/backend/backend.dart';

class JishoDictionaryRepository extends DictionaryRepository {
  @override
  Future<UnmodifiableListView<Word>> findWord(String query) async {
    throw UnimplementedError();
  }
}
