import 'package:intl/intl.dart';

class HomeStrings {
  String welcomeHeader(String name) {
    return Intl.message(
      'Welcome back,\n$name.',
      name: 'welcomeHeader',
      desc: 'Welcome message displayed at the top of the screen '
          'that greets the user.',
      args: [name],
      examples: const {'name': 'Jay'},
    );
  }

  String get guessesStatisticTitle {
    return Intl.message(
      'Guesses',
      name: 'guessesStatisticTitle',
      desc: 'The header for the statistic showing the number of guesses '
          'the user has made in total.',
    );
  }

  String get pointsStatisticTitle {
    return Intl.message(
      'Points',
      name: 'pointsStatisticTitle',
      desc: 'The header for the statistic showing the number of points '
          'the user has in total.',
    );
  }

  String get rankStatisticTitle {
    return Intl.message(
      'Rank',
      name: 'rankStatisticTitle',
      desc: 'The header for the statistic showing the rank of the user '
          'compared to all other users.',
    );
  }

  String get singleplayerCardTitle {
    return Intl.message(
      'Singleplayer',
      name: 'singleplayerCardTitle',
      desc: 'Title on the Singleplayer card that '
          'allows the user to start a quick play match.',
    );
  }

  String get singleplayerCardSubtitle {
    return Intl.message(
      'AGAINST CPU',
      name: 'singleplayerCardSubtitle',
      desc: 'Subtitle on the Singleplayer card that '
          'indicates it is a new game mode. '
          'Should be all capitals if applicable.',
    );
  }

  String get multiplayerCardTitle {
    return Intl.message(
      'Multiplayer',
      name: 'multiplayerCardTitle',
      desc: 'Title on the Multiplayer card that '
          'allows the user to start a multiplayer match.',
    );
  }

  String get multiplayerCardSubtitle {
    return Intl.message(
      'WITH FRIENDS',
      name: 'multiplayerCardSubtitle',
      desc: 'Subtitle on the Multiplayer card that '
          'indicates the user can play with friends. '
          'Should be all capitals if applicable.',
    );
  }

  String get statsCardTitle {
    return Intl.message(
      'Stats',
      name: 'statsCardTitle',
      desc: 'Title on the Stats card that '
          'allows the user to view their stats '
          'and rank compared to other users.',
    );
  }

  String get statsCardSubtitle {
    return Intl.message(
      'RANKING',
      name: 'statsCardSubtitle',
      desc: 'Subtitle on the Stats card that '
          'indicates the user can see their ranking. '
          'Should be all capitals if applicable.',
    );
  }

  String get settingsCardTitle {
    return Intl.message(
      'Settings',
      name: 'settingsCardTitle',
      desc: 'Title on the Settings card that '
          'allows the user to view their settings.',
    );
  }

  String get settingsCardSubtitle {
    return Intl.message(
      'CUSTOMIZE',
      name: 'settingsCardSubtitle',
      desc: 'Subtitle on the Settings card that '
          'indicates the user can customize their settings. '
          'Should be all capitals if applicable.',
    );
  }

  String get quickPlayButtonTitle {
    return Intl.message(
      'Quick Play',
      name: 'quickPlayButtonTitle',
      desc: 'Text on the Quick Play button that '
          'instantly starts a singleplayer CPU match.',
    );
  }
}
