import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';
import 'package:shiritori/utils/utils.dart';

class WordEntryDetailsCard extends StatelessWidget {
  const WordEntryDetailsCard({
    Key key,
    @required this.wordEntry,
  }) : super(key: key);

  final WordEntry wordEntry;

  String get primarySpelling => wordEntry.mostSuitableSpelling;

  List<String> get secondarySpellings {
    return List<String>.of(wordEntry.phoneticSpellings)
      ..remove(primarySpelling)
      ..sort((first, second) => second.length.compareTo(first.length));
  }

  List<String> get tertiarySpellings {
    return List<String>.of(wordEntry.spellings)
      ..remove(primarySpelling)
      ..sort((first, second) => second.length.compareTo(first.length));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final primarySpelling = this.primarySpelling;

    final primarySpellingParts = primarySpelling.chipOffLast();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: primarySpellingParts.left),
                        TextSpan(
                          style: const TextStyle(color: AppTheme.orange),
                          text: primarySpellingParts.right,
                        ),
                      ],
                    ),
                    style: textTheme.headline4,
                  ),
                  for (final spelling in secondarySpellings)
                    Text(
                      spelling,
                      style: textTheme.headline5.copyWith(
                        color: textTheme.headline5.color.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
              verticalMargin8,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (final spelling in tertiarySpellings)
                    Text(
                      spelling,
                      style: textTheme.headline6.copyWith(
                        color: textTheme.bodyText1.color.withOpacity(0.6),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                ],
              ),
              verticalMargin8,
              for (final definition in wordEntry.definitions.take(4))
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(' ・ '),
                    Expanded(
                      child: Text(definition),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
