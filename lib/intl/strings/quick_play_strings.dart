import 'package:intl/intl.dart';

class QuickPlayStrings {
  String get title {
    return Intl.message(
      'Quick Play',
      name: 'title',
      desc: 'The header for the Quick Play page. '
          'Usually, this string should be the same as '
          'HomeStrings.quickPlayCardTitle.',
    );
  }
}
