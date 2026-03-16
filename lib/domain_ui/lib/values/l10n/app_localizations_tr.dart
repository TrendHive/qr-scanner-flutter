// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get copyMessage => 'Panoya kopyalandı!';

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String get clickedTitle => 'Tıklananlar';

  @override
  String get emptyHistory => 'Geçmiş boş';

  @override
  String get emptyClicked => 'Henüz tıklanan yok';
}
