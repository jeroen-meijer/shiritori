import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class GuessDetailsCard extends StatelessWidget {
  const GuessDetailsCard({
    Key key,
    this.backgroundColor,
    @required this.guessWithEntry,
  }) : super(key: key);

  final Color backgroundColor;
  final Tuple<String, WordEntry> guessWithEntry;

  String get guess => guessWithEntry.left;
  WordEntry get entry => guessWithEntry.right;

  String get primarySpelling => guess;

  List<String> get secondarySpellings {
    return List<String>.of(entry.phoneticSpellings)
      ..remove(primarySpelling)
      ..sort((first, second) => second.length.compareTo(first.length));
  }

  List<String> get tertiarySpellings {
    return List<String>.of(entry.spellings)
      ..remove(primarySpelling)
      ..sort((first, second) => second.length.compareTo(first.length));
  }

  @override
  Widget build(BuildContext context) {
    final originalTheme = Theme.of(context);
    final adjustedBackgroundColor =
        backgroundColor ?? originalTheme.cardTheme.color;
    final adjustedTextColor = backgroundColor == null
        ? null
        : adjustedBackgroundColor.computeLuminance() > 0.7
            ? AppTheme.darkGrey
            : AppTheme.white;

    final theme = originalTheme.copyWith(
      cardTheme: originalTheme.cardTheme.copyWith(
        color: adjustedBackgroundColor,
      ),
      textTheme: originalTheme.textTheme.apply(
        bodyColor: adjustedTextColor,
        displayColor: adjustedTextColor,
      ),
    );
    final textTheme = theme.textTheme;

    final language = context
        .select<Game, Language>((game) => game.settings.dictionary.language);

    final primarySpelling = this.primarySpelling;
    final highlightedPart = language.selectEndingCharacter(primarySpelling);
    final nonHighlightedPart = primarySpelling.substring(
      0,
      primarySpelling.lastIndexOf(highlightedPart),
    );

    return Theme(
      data: theme,
      child: Card(
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
                          TextSpan(text: nonHighlightedPart),
                          TextSpan(
                            style: const TextStyle(color: AppTheme.orange),
                            text: highlightedPart,
                          ),
                        ],
                      ),
                      style: textTheme.headline4,
                    ),
                    for (final spelling in secondarySpellings.take(4))
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
                    for (final spelling in tertiarySpellings.take(4))
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
                for (final definition in entry.definitions.take(4))
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
      ),
    );
  }
}
