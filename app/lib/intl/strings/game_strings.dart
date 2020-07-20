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
}
