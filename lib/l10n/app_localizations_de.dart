// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Heute';

  @override
  String get navChart => 'Kurve';

  @override
  String get navInsights => 'Statistik';

  @override
  String get navLearn => 'Lernen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get supportTitle => 'Ember unterstützen';

  @override
  String get supportHeadline => 'Ember ist kostenlos – und bleibt es';

  @override
  String get supportBody =>
      'Keine Abos, keine Werbung, kein Tracking. Alle Funktionen stehen allen offen. Ember wird in meiner Freizeit entwickelt und gepflegt.\n\nWenn Ember dir nützt und du die Entwicklung unterstützen möchtest, kannst du einen kleinen Betrag geben. Das ist völlig freiwillig und schaltet nichts frei – du hast bereits die komplette App.';

  @override
  String get supportButton => 'Spendier mir einen Kaffee';

  @override
  String get supportFootnote =>
      'Öffnet sich im Browser. Ember sieht deine Zahlungsdaten nie.';

  @override
  String get supportLinkError => 'Link konnte nicht geöffnet werden';
}
