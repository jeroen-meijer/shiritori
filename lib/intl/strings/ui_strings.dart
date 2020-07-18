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
}
