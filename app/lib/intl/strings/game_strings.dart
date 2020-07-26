import 'package:intl/intl.dart';

class GameStrings {
  String get singleplayerTitle {
    return Intl.message(
      'Singleplayer',
      name: 'singleplayerTitle',
      desc: 'The header for the Singleplayer page. '
          'Usually, this string should be the same as '
          'HomeStrings.singleplayerCardTitle.',
    );
  }

  String get multiplayerTitle {
    return Intl.message(
      'Multiplayer',
      name: 'multiplayerTitle',
      desc: 'The header for the Multiplayer page. '
          'Usually, this string should be the same as '
          'HomeStrings.multiplayerCardTitle.',
    );
  }

  String get getReady {
    return Intl.message(
      'Get Ready...',
      name: 'getReady',
      desc: 'Text indicating a match is about to start '
          'and the player needs to start paying attention '
          'and get themselves ready.',
    );
  }

  String get restart {
    return Intl.message(
      'Restart',
      name: 'restart',
      desc: 'Button text displayed on the restart button '
          'that, when pressed, will start a new game with '
          'the same settings.',
    );
  }

  String get invalidGuessHeader {
    return Intl.message(
      'Invalid guess',
      name: 'invalidGuessHeader',
      desc: 'The header text shown in a guess card '
          'indicating a guess is invalid.',
    );
  }

  String get invalidGuessReasonDoesNotFollowPattern {
    return Intl.message(
      'This word does not start with the last character '
      'of the last guess.',
      name: 'invalidGuessReasonDoesNotFollowPattern',
      desc: 'Text shown below the invalidGuessHeader '
          'explaining the guess is invalid because the '
          'guess does not follow the intended pattern.',
    );
  }

  String get invalidGuessReasonInvalidWord {
    return Intl.message(
      'This word ends with an invalid character.',
      name: 'invalidGuessReasonInvalidWord',
      desc: 'Text shown below the invalidGuessHeader '
          'explaining the guess is invalid because '
          'the guess is an invalid word.',
    );
  }

  String get invalidGuessReasonAlreadyGuessed {
    return Intl.message(
      'This word has already been guessed.',
      name: 'invalidGuessReasonAlreadyGuessed',
      desc: 'Text shown below the invalidGuessHeader '
          'explaining the guess is invalid because '
          'the guess has already been guessed before.',
    );
  }

  String get invalidGuessReasonDoesNotExist {
    return Intl.message(
      "We couldn't find this word in our dictionary.",
      name: 'invalidGuessReasonDoesNotExist',
      desc: 'Text shown below the invalidGuessHeader '
          'explaining the guess is invalid because '
          'the guessed word does not exist in the '
          'dictionary.',
    );
  }
}
