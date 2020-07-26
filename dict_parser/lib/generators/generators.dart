import 'dart:io';

import 'package:dict_parser/utils.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:shared_models/shared_models.dart';
import 'package:xml/xml.dart';

part 'japanese.dart';

class Generator {
  const Generator._({
    @required this.language,
    this.customEntries = const [],
    @required this.generateEntries,
  });

  final Language language;
  final Iterable<WordEntry> customEntries;
  final Future<Iterable<WordEntry>> Function(List<String> args) generateEntries;

  static final Generator japanese = _japanese;

  static final List<Generator> all = [_japanese];
}
