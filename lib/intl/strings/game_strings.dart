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
}
