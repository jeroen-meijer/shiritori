import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';

class Game extends ChangeNotifier {
  Game({
    @required this.settings,
    @required this.startingPlayerIndex,
    @required this.guessesByPlayerIndex,
    this.winningPlayerIndex,
  })  : assert(settings != null),
        assert(startingPlayerIndex != null),
        assert(guessesByPlayerIndex != null);

  factory Game.startNew(GameSettings settings) {
    final startWithCpu =
        settings is SingleplayerGameSettings && settings.startWithCpuMove;
    final startingPlayerIndex = startWithCpu ? 1 : 0;

    return Game(
      settings: settings,
      startingPlayerIndex: startingPlayerIndex,
      guessesByPlayerIndex: {
        0: {},
        1: {
          if (startWithCpu)
            settings.dictionary.entries.random.phoneticSpellings
                .where(settings.dictionary.language.validate)
                .random,
        }
      },
      winningPlayerIndex: null,
    );
  }

  static Game of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<Game>(context, listen: listen);
  }

  final GameSettings settings;
  final int startingPlayerIndex;
  final Map<int, Set<String>> guessesByPlayerIndex;
  int winningPlayerIndex;

  void addGuess(String guess) {
    assert(guess != null);

    final guessValidity = validateGuess(guess);
    assert(
      guessValidity.isValid,
      'Guess ("$guess") is not valid ($guessValidity).',
    );

    log('addGuess running...');

    guessesByPlayerIndex[0] = guessesByPlayerIndex[0]..add(guess);

    final shouldMakeCpuGuess = settings is SingleplayerGameSettings &&
        (settings as SingleplayerGameSettings).startWithCpuMove;

    if (shouldMakeCpuGuess) {
      log('shouldMakeCpuGuess...');
      final startingCharacter = startingCharacterForNextGuess;
      final nextWord = settings.dictionary
          .searchWordsThatStartsWith(startingCharacter)
          .random
          .phoneticSpellings
          .whereOrEmpty(settings.dictionary.language.validate)
          .randomOrNull;

      if (nextWord == null) {
        // CPU has no guesses left. User wins.
        winningPlayerIndex = 0;
      } else {
        log('add cpu guess...');
        guessesByPlayerIndex[1] = guessesByPlayerIndex[1]..add(nextWord);
      }
    }

    notifyListeners();
  }

  int get playerIndexForLastGuess {
    return 1 - playerIndexForNextGuess;
  }

  int get playerIndexForNextGuess {
    final isStartingPlayersTurn = allGuessesByPlayerIndex.length % 2 == 0;
    return isStartingPlayersTurn
        ? startingPlayerIndex
        : 1 - startingPlayerIndex;
  }

  Set<Tuple<int, String>> get allGuessesByPlayerIndex {
    var entries = guessesByPlayerIndex.entries
        .map((entry) => entry.value.map((guess) => Tuple(entry.key, guess)))
        .toList();

    if (startingPlayerIndex == 1) {
      entries = entries.reversed.toList();
    }

    return entries.alternate().toSet();
  }

  Set<Tuple<int, Tuple<String, WordEntry>>>
      get allGuessesWithWordEntriesByPlayerIndex {
    return allGuessesByPlayerIndex.map((playerGuess) {
      return playerGuess.mapRight((guess) {
        return Tuple(guess, settings.dictionary.searchWords(guess).first);
      });
    }).toSet();
  }

  /// Returns a [Tuple] with the player index of the last guess and the guess
  /// itself.
  ///
  /// If no guesses have been made yet, this returns `null`.
  Tuple<int, String> get lastGuess {
    final playerIndex = playerIndexForLastGuess;
    final guess = guessesByPlayerIndex[playerIndex].lastOrNull;
    if (guess == null) {
      return null;
    }

    return Tuple(playerIndex, guess);
  }

  String get startingCharacterForNextGuess {
    final lastGuess = this.lastGuess;
    if (lastGuess == null) {
      return null;
    }

    return settings.dictionary.language.selectEndingCharacter(lastGuess.right);
  }

  String transformGuess(String guess) {
    return settings.dictionary.language.transform(guess);
  }

  GuessValidity validateGuess(String guess) {
    log('[${DateTime.now()}] VALIDATING "$guess"');
    final language = settings.dictionary.language;

    final followsPattern = startingCharacterForNextGuess ==
        language.selectStartingCharacter(guess);

    if (!followsPattern) {
      log('doesNotFollowPattern...');
      return GuessValidity.doesNotFollowPattern;
    }

    final isValidWord = settings.dictionary.language.validate(guess);
    if (!isValidWord) {
      log('invalidWord...');
      return GuessValidity.invalidWord;
    }

    final hasBeenGuessed = allGuessesByPlayerIndex.contains(guess);
    if (hasBeenGuessed) {
      log('alreadyGuessed...');
      return GuessValidity.alreadyGuessed;
    }

    if (settings.dictionary.phoneticIndicies[guess] == null) {
      log('doesNotExist...');
      return GuessValidity.doesNotExist;
    }

    log('valid...');
    return GuessValidity.valid;
  }
}
