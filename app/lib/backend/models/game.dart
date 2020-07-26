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
  })  : assert(settings != null),
        assert(startingPlayerIndex != null),
        assert(guessesByPlayerIndex != null);

  factory Game.startNew(GameSettings settings) {
    final startWithCpu =
        settings is SingleplayerGameSettings && settings.startWithCpuMove;
    final startingPlayerIndex = startWithCpu ? 1 : 0;
    final cpuStartingGuess =
        !startWithCpu ? null : settings.dictionary.entries.random;

    return Game(
      settings: settings,
      startingPlayerIndex: startingPlayerIndex,
      guessesByPlayerIndex: {
        0: {},
        1: {
          if (startWithCpu)
            Guess(
              query: cpuStartingGuess.phoneticSpellings
                  .where(settings.dictionary.language.validate)
                  .random,
              validity: GuessValidity.valid,
              entry: cpuStartingGuess,
            ),
        }
      },
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
  final Map<int, Set<Guess>> guessesByPlayerIndex;

  Language get language => settings.dictionary.language;

  int get winningPlayerIndex => _winningPlayerIndex;
  int _winningPlayerIndex;

  bool get isFinished => _winningPlayerIndex != null;

  Guess _queryToGuess(String query) {
    void _log(int id, String message) {
      log(
        message,
        name: '_queryToGuess',
        sequenceNumber: id,
        time: DateTime.now(),
      );
    }

    _log(0, 'query: "$query"');

    _log(1, 'startingCharacterForNextGuess: $startingCharacterForNextGuess');
    final followsPattern = startingCharacterForNextGuess ==
        language.selectStartingCharacter(query);

    GuessValidity validity;

    if (!followsPattern) {
      _log(2, 'doesNotFollowPattern...');
      validity = GuessValidity.doesNotFollowPattern;
    }

    final isValidWord = language.validate(query);
    if (!isValidWord) {
      _log(3, 'invalidWord...');
      validity = GuessValidity.invalidWord;
    }

    final hasBeenGuessed = allGuessesByPlayerIndex.contains(query);
    if (hasBeenGuessed) {
      _log(4, 'alreadyGuessed...');
      validity = GuessValidity.alreadyGuessed;
    }

    final entries = settings.dictionary.searchWords(query);

    if (entries.isEmpty) {
      _log(5, 'doesNotExist...');
      validity = GuessValidity.doesNotExist;
    }

    validity ??= GuessValidity.valid;

    final guess = Guess(
      query: query,
      validity: validity,
      entry: entries.firstOrNull,
    );

    _log(6, 'guess: $guess');

    return guess;
  }

  void addGuess(String query) {
    assert(query != null);

    final guess = _queryToGuess(query);

    guessesByPlayerIndex[0] = guessesByPlayerIndex[0]..add(guess);

    if (guess.isInvalid) {
      _winningPlayerIndex = 1;
    } else {
      final shouldMakeCpuGuess = settings is SingleplayerGameSettings &&
          (settings as SingleplayerGameSettings).startWithCpuMove;

      if (shouldMakeCpuGuess) {
        log('shouldMakeCpuGuess...');
        final startingCharacter = startingCharacterForNextGuess;
        final nextWord = settings.dictionary
            .searchWordsThatStartsWith(startingCharacter)
            .random;

        if (nextWord == null) {
          // CPU has no guesses left. User wins.
          _winningPlayerIndex = 0;
        } else {
          log('add cpu guess...');
          guessesByPlayerIndex[1] = guessesByPlayerIndex[1]
            ..add(
              Guess(
                query:
                    nextWord.phoneticSpellings.where(language.validate).random,
                validity: GuessValidity.valid,
                entry: nextWord,
              ),
            );
        }
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

  Set<Tuple<int, Guess>> get allGuessesByPlayerIndex {
    // A list with two elements, both of which are iterables that contain all
    // guesses from that respective player.
    var entries = guessesByPlayerIndex.entries
        .map((entry) => entry.value.map((guess) => Tuple(entry.key, guess)))
        .toList();

    // Makes sure that the first list in the entries are the ones of the
    // starting player.
    if (startingPlayerIndex == 1) {
      entries = entries.reversed.toList();
    }

    // Returns the guesses in alternating fashion.
    return entries.alternate().toSet();
  }

  /// Returns a [Tuple] with the player index of the last guess and the guess
  /// itself.
  ///
  /// If no guesses have been made yet, this returns `null`.
  Tuple<int, Guess> get lastGuess {
    final playerIndex = playerIndexForLastGuess;
    final guess = guessesByPlayerIndex[playerIndex].lastOrNull;
    if (guess == null) {
      return null;
    }

    return Tuple(playerIndex, guess);
  }

  String get startingCharacterForNextGuess {
    if (lastGuess == null) {
      return null;
    }

    return language.selectEndingCharacter(lastGuess.right.query);
  }

  String transformGuess(String guess) {
    return language.mapToLanguage(guess);
  }
}
