part of '../language.dart';

const _kanaKit = KanaKit();
const _smallHiragana = ['ゃ', 'ゅ', 'ょ'];

final _japanese = Language(
  code: 'ja',
  name: '日本語',
  transform: (input) {
    return _kanaKit.toHiragana(input);
  },
  validate: (input) {
    final isHiragana = _kanaKit.isHiragana(input);
    final endsWithN = input.endsWith('ん');

    return isHiragana && !endsWithN;
  },
  selectStartingCharacter: (input) {
    if (input.length < 2) {
      return input;
    } else if (_smallHiragana.contains(input[1])) {
      return input.substring(0, 2);
    } else {
      return input.chars.first;
    }
  },
  selectEndingCharacter: (input) {
    if (input.length < 2) {
      return input;
    } else if (_smallHiragana.contains(input.chars.last)) {
      return input.reversed.substring(0, 2).reversed;
    } else {
      return input.chars.last;
    }
  },
);
