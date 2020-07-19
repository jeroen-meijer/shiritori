import 'dart:collection';

import 'package:meta/meta.dart';

enum WordMeaningType {
  noun,
  verb,
  other,
}

class Word {
  Word({
    @required this.text,
    @required this.definition,
    @required this.type,
    UnmodifiableListView<String> tags,
  })  : assert(text != null),
        assert(definition != null),
        assert(type != null),
        tags = tags ?? UnmodifiableListView([]);

  final String text;
  final String definition;
  final WordMeaningType type;
  final UnmodifiableListView<String> tags;
}
