import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/utils/utils.dart';

class Game {
  const Game({
    @required this.settings,
    @required this.guessesByPlayerIndex,
    this.winningPlayerIndex,
  })  : assert(settings != null),
        assert(guessesByPlayerIndex != null);

  factory Game.startNew(GameSettings settings) {
    return Game(
      settings: settings,
      guessesByPlayerIndex: {
        0: {},
        1: {
          if (settings is SingleplayerGameSettings && settings.startWithCpuMove)
            settings.dictionary.entries.random.mostSuitableSpelling,
        }
      },
      winningPlayerIndex: null,
    );
  }

  static Game of(BuildContext context) {
    return Provider.of<Game>(context, listen: false);
  }

  final GameSettings settings;
  final Map<int, Set<String>> guessesByPlayerIndex;
  final int winningPlayerIndex;

  Set<String> get allGuesses {
    return guessesByPlayerIndex.entries.expand((entry) => entry.value).toSet();
  }

  bool hasBeenGuessed(String guess) {
    return allGuesses.contains(guess);
  }

  bool isValidGuess(String guess) {
    return hasBeenGuessed(guess);
  }
}
