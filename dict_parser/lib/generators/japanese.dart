part of 'generators.dart';

final _japanese = Generator._(
  language: Language.japanese,
  customEntries: [
    const WordEntry(
      spellings: ['時間'],
      phoneticSpellings: ['じかん'],
      definitions: ['time', 'hours'],
    ),
    const WordEntry(
      spellings: ['質問'],
      phoneticSpellings: ['しつもん'],
      definitions: ['question', 'query'],
    ),
  ],
  generateEntries: (args) async {
    const _nounTag = '&n;';
    const _spellingElementPath = ['k_ele', 'keb'];
    const _phoneticSpellingElementPath = ['r_ele', 'reb'];
    const _definitionsElementPath = ['sense', 'gloss'];

    const kanaKit = KanaKit();

    final xmlFileName = args.first;
    final xmlFile = File(xmlFileName);

    print('Parsing XML file (${xmlFile.path})');
    final doc = XmlDocument.parse(await xmlFile.readAsString());

    final xmlEntries = doc.getElement('JMdict').findAllElements('entry');

    print('Parsing entries');
    return xmlEntries.map<WordEntry>((entry) {
      final posData = entry
          .getElement('sense')
          .findAllElements('pos')
          .map((posElement) => posElement.text);
      if (!posData.contains(_nounTag)) {
        return null;
      }

      final spellings = entry
          .findAllElementsDeep(_spellingElementPath)
          .mapEachToText()
          .toList(growable: false);

      final phoneticSpellingsRaw = entry
          .findAllElementsDeep(_phoneticSpellingElementPath)
          .mapEachToText()
          .toSet();
      if (phoneticSpellingsRaw.isEmpty) {
        return null;
      }

      final phoneticSpellings = {
        for (final spelling in phoneticSpellingsRaw) ...{
          if (kanaKit.isKana(spelling)) ...{
            spelling,
            kanaKit.toHiragana(spelling),
          }
        },
      }.toList(growable: false);

      if (phoneticSpellings.any(Language.japanese.validate) == false) {
        return null;
      }

      final definitions = entry
          .findAllElementsDeep(_definitionsElementPath)
          .mapEachToText()
          .toList(growable: false);

      return WordEntry(
        spellings: spellings,
        phoneticSpellings: phoneticSpellings,
        definitions: definitions,
      );
    }).where((entry) => entry != null);
  },
);
