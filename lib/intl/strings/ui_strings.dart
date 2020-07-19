import 'package:intl/intl.dart';

class UiStrings {
  String get snackBarConfirmButton {
    return Intl.message(
      'OK',
      name: 'snackBarConfirmButton',
      desc: 'Button text displayed on a snackbar '
          'that confirms and dismisses it.',
    );
  }

  String get back {
    return Intl.message(
      'BACK',
      name: 'back',
      desc: 'Button text displayed on back buttons '
          'that confirms and dismisses it. '
          'Should be all capitals if applicable.',
    );
  }
}
