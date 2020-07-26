import 'package:flutter/widgets.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:shiritori/intl/messages/messages_all.dart';

class ShiritoriLocalizations {
  const ShiritoriLocalizations();

  static const LocalizationsDelegate<ShiritoriLocalizations> delegate =
      _ShiritoriLocalizationsDelegate();

  static Future<ShiritoriLocalizations> load(Locale locale) async {
    final localeString = '$locale';

    final name = locale?.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : localeString;

    final localeName = Intl.canonicalizedLocale(name);

    Intl.defaultLocale = localeString;

    await initializeMessages(localeName);

    return const ShiritoriLocalizations();
  }

  static ShiritoriLocalizations of(BuildContext context) {
    return Localizations.of<ShiritoriLocalizations>(
        context, ShiritoriLocalizations);
  }

  HomeStrings get home => HomeStrings();
  UiStrings get ui => UiStrings();
  GameStrings get game => GameStrings();
}

class _ShiritoriLocalizationsDelegate
    extends LocalizationsDelegate<ShiritoriLocalizations> {
  const _ShiritoriLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    for (final supportedLocale in supportedLocales) {
      // For now, we're ignoring country codes.
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }

    return false;
  }

  @override
  Future<ShiritoriLocalizations> load(Locale locale) =>
      ShiritoriLocalizations.load(locale);

  @override
  bool shouldReload(_ShiritoriLocalizationsDelegate old) => false;
}
