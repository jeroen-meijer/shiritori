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

  String get quickPlayCardTitle {
    return Intl.message(
      'Quick Play',
      name: 'quickPlayCardTitle',
      desc: 'Title on the Quick Play card that '
          'allows the user to start a quick play match.',
    );
  }

  String get quickPlayCardSubtitle {
    return Intl.message(
      'Play against CPU',
      name: 'quickPlayCardSubtitle',
      desc: 'Subtitle on the Quick Play card that '
          'indicates it is a new game mode.',
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
      'Play with friends',
      name: 'multiplayerCardSubtitle',
      desc: 'Subtitle on the Multiplayer card that '
          'indicates the user can play with friends.',
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
      'Ranking',
      name: 'statsCardSubtitle',
      desc: 'Subtitle on the Stats card that '
          'indicates the user can see their ranking.',
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
      'Customize',
      name: 'settingsCardSubtitle',
      desc: 'Subtitle on the Settings card that '
          'indicates the user can customize their settings.',
    );
  }
}
