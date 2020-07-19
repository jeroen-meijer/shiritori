import 'dart:convert';
import 'dart:io';

import 'package:dict_parser/utils.dart';
import 'package:shared_models/shared_models.dart';
import 'package:xml/xml.dart';

// TODO: Move to config wrapper class for better compatibilty with other dicts.
const _nounTag = '&n;';
const _spellingElementPath = ['k_ele', 'keb'];
const _phoneticSpellingElementPath = ['r_ele', 'reb'];
const _definitionsElementPath = ['sense', 'gloss'];

Stopwatch _stopwatch;

Future<void> main(List<String> args) async {
  print('Starting...');

  if (args.isEmpty || args.length > 1) {
    print(
      '0 or more than 1 arg provided. '
      'Please provide the XML file to parse '
      'as the first and only argument.',
    );
    exit(1);
  }

  final xmlFileName = args.first;
  final xmlFile = File(xmlFileName);

  _time('Parsing XML file (${xmlFile.path})');
  final doc = XmlDocument.parse(await xmlFile.readAsString());
  _stopTime();

  final xmlEntries = doc.getElement('JMdict').findAllElements('entry');
  final xmlNouns = xmlEntries.where((entry) {
    final posData = entry
        .getElement('sense')
        .findAllElements('pos')
        .map((posElement) => posElement.text);

    return posData.contains(_nounTag);
  });

  _time('Parsing nouns');
  final nouns = xmlNouns.map((noun) {
    final spellings = noun
        .findAllElementsDeep(_spellingElementPath)
        .mapEachToText()
        .toList(growable: false);
    final phoneticSpellings = noun
        .findAllElementsDeep(_phoneticSpellingElementPath)
        .mapEachToText()
        .toList(growable: false);
    final definitions = noun
        .findAllElementsDeep(_definitionsElementPath)
        .mapEachToText()
        .toList(growable: false);

    return WordEntry(
      spellings: spellings,
      phoneticSpellings: phoneticSpellings,
      definitions: definitions,
    );
  }).toList(growable: false);
  _stopTime();

  _time('Indexing into dictionary...');
  final dictionary = Dictionary.fromEntries(
    language: Language.japanese,
    entries: nouns,
  );
  _stopTime();

  print('Nouns parsed: ${nouns.length}');

  _time('Serializing dictionary to JSON');
  final serializedDictionary = json.encode(dictionary);
  _stopTime();

  final exportFile = File(
    '${xmlFileName.split('.').first}_'
    '${DateTime.now().millisecondsSinceEpoch}.json',
  );

  _time('Exporting to file (${exportFile.path})');
  await exportFile.writeAsString(serializedDictionary);
  _stopTime();

  print('Quitting...');
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
  print(
    'Done. (took $seconds seconds)',
  );
}
