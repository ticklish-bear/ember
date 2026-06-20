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

  @override
  String get settingsGoal => 'Ziel';

  @override
  String get settingsUseFor => 'Ich nutze STM zum';

  @override
  String get purposeAvoiding => 'Verhüten';

  @override
  String get purposeAchieving => 'Erfüllen';

  @override
  String get purposeAvoidingDesc =>
      'Die Bezeichnungen sind vorsichtig gewählt – nur bestätigte Phasen werden als unfruchtbar markiert.';

  @override
  String get purposeAchievingDesc =>
      'Die Bezeichnungen nutzen die übliche STM-Terminologie zur Bestimmung des fruchtbaren Fensters.';

  @override
  String get settingsTracking => 'Erfassung';

  @override
  String get settingsTempUnit => 'Temperatureinheit';

  @override
  String get settingsRuleset => 'STM-Regelwerk';

  @override
  String get settingsCervix => 'Muttermund erfassen';

  @override
  String get settingsCervixSub => 'Position, Öffnung & Festigkeit';

  @override
  String get settingsIntercourse => 'Geschlechtsverkehr erfassen';

  @override
  String get settingsOpenEntryVia => 'Tageseintrag öffnen mit';

  @override
  String get tapLongPress => 'Lang drücken';

  @override
  String get tapDoubleTap => 'Doppeltippen';

  @override
  String get settingsAutoDetection => 'Automatische Erkennung';

  @override
  String get settingsAutoCoverline => 'Hilfslinie automatisch';

  @override
  String get settingsAutoCoverlineSub => '3-über-6-Regel';

  @override
  String get settingsAutoPeak => 'Höhepunkt automatisch';

  @override
  String get settingsAutoPeakSub => 'Aus dem Schleimmuster';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsDailyReminder => 'Tägliche Erinnerung';

  @override
  String get settingsDailyReminderSub =>
      'Eine Benachrichtigung pro Tag, um Temperatur und Schleim einzutragen.';

  @override
  String get settingsReminderTime => 'Uhrzeit der Erinnerung';

  @override
  String get settingsData => 'Daten';

  @override
  String get settingsExport => 'Daten exportieren (CSV)';

  @override
  String get settingsExportSub => 'Alle Daten als CSV speichern';

  @override
  String get settingsImport => 'Daten importieren (CSV)';

  @override
  String get settingsImportSub => 'Ember-CSV-Format importieren';

  @override
  String get settingsImportKindara => 'Aus Kindara importieren';

  @override
  String get settingsImportKindaraSub => 'Kindara-Exportdatei importieren';

  @override
  String get settingsDeleteAll => 'Alle Daten löschen';

  @override
  String get settingsDeleteAllSub => 'Kann nicht rückgängig gemacht werden';

  @override
  String get settingsAbout => 'Über';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsPrivacySub =>
      'Alle Daten lokal gespeichert. Kein Konto nötig.';

  @override
  String get settingsAboutStm => 'Über STM';

  @override
  String get settingsAboutStmSub =>
      'Kompatibel mit der symptothermalen Methode. Unabhängige App, nicht mit einer Organisation verbunden.';

  @override
  String get settingsSupport => 'Unterstützen';

  @override
  String get settingsSupportDev => 'Entwicklung unterstützen';

  @override
  String get settingsSupportDevSub =>
      'Ember ist kostenlos. Spendier einen Kaffee, wenn du magst – freiwillig.';

  @override
  String get exportCompleteTitle => 'Export abgeschlossen';

  @override
  String exportCompleteBody(String path) {
    return 'Datei gespeichert unter:\n$path\n\nMöchtest du sie teilen?';
  }

  @override
  String get close => 'Schließen';

  @override
  String get share => 'Teilen';

  @override
  String exportFailed(String error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count Einträge importiert';
  }

  @override
  String importFailed(String error) {
    return 'Import fehlgeschlagen: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count Kindara-Einträge importiert';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Kindara-Import fehlgeschlagen: $error';
  }

  @override
  String get deleteAllTitle => 'Alle Daten löschen?';

  @override
  String get deleteAllBody =>
      'Damit werden alle deine Zyklen und Einträge dauerhaft gelöscht. Exportiere deine Daten vorher am besten.\n\nDiese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get deleteEverything => 'Alles löschen';

  @override
  String get allDataDeleted => 'Alle Daten gelöscht';
}
