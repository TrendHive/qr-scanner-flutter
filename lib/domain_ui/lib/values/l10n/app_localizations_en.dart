// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get copyMessage => 'Copied to clipboard!';

  @override
  String get historyTitle => 'History';

  @override
  String get clickedTitle => 'Clicked';

  @override
  String get emptyHistory => 'History is empty';

  @override
  String get emptyClicked => 'No items clicked yet';
}
