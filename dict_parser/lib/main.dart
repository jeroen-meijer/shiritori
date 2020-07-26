import 'dart:convert';
import 'dart:io';

import 'package:dict_parser/generators/generators.dart';
import 'package:shared_models/shared_models.dart';

const _entryCountLimit = 70000;

Stopwatch _stopwatch;

Future<void> main(List<String> args) async {
  print('Starting (entry limit per dictionary: $_entryCountLimit)');

  if (args.isEmpty || args.length > 1) {
    print(
      '0 or more than 1 arg provided. '
      'Please provide the XML file to parse '
      'as the first and only argument.',
    );
    exit(1);
  }

  _stopTime();

  print(
    'Generating dictionaries for all languages '
    '${Generator.all.map((g) => g.language.code)}...',
  );

  for (final generator in Generator.all) {
    _time('Generating entries for language "${generator.language.code}"');
    final entries =
        (await generator.generateEntries(args)).take(_entryCountLimit).toList();
    print('Entries parsed: ${entries.length}');

    _time('Adding custom entries');
    entries.addAll(generator.customEntries);

    _time('Indexing into dictionary');
    final dictionary = Dictionary.fromEntries(
      language: generator.language,
      entries: entries,
    );

    _time('Serializing dictionary to JSON');
    final serializedDictionary = json.encode(dictionary);

    final exportFile = File(
      'dict_${dictionary.language.code}.json',
    );
    _time('Exporting to file (${exportFile.path})');
    await exportFile.writeAsString(serializedDictionary);
    _stopTime();

    print('Dictionary generated for language "${generator.language.code}"');
  }

  print('Quitting');
  exit(0);
}

void _time(String process) {
  _stopTime();
  print('$process...');
  _stopwatch = Stopwatch()..start();
}

void _stopTime() {
  if (_stopwatch == null || !_stopwatch.isRunning) {
    return;
  }

  _stopwatch.stop();
  final seconds = (_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(3);
  print('Done. (took $seconds seconds)\n');
}
