// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Today';

  @override
  String get navChart => 'Chart';

  @override
  String get navInsights => 'Insights';

  @override
  String get navLearn => 'Learn';

  @override
  String get navSettings => 'Settings';

  @override
  String get supportTitle => 'Support Ember';

  @override
  String get supportHeadline => 'Ember is free — and stays that way';

  @override
  String get supportBody =>
      'No subscriptions, no ads, no tracking. Every feature is available to everyone. It’s built and maintained in my spare time.\n\nIf Ember is useful to you and you’d like to chip in toward its development, you can leave a small tip. It’s entirely optional and unlocks nothing — you already have the whole app.';

  @override
  String get supportButton => 'Buy me a coffee';

  @override
  String get supportFootnote =>
      'Opens in your browser. Ember never sees your payment details.';

  @override
  String get supportLinkError => 'Could not open the link';

  @override
  String get settingsGoal => 'Goal';

  @override
  String get settingsUseFor => 'I use STM for';

  @override
  String get purposeAvoiding => 'Avoiding';

  @override
  String get purposeAchieving => 'Achieving';

  @override
  String get purposeAvoidingDesc =>
      'Labels reflect a cautious approach — only confirmed phases are marked infertile.';

  @override
  String get purposeAchievingDesc =>
      'Labels use standard STM terminology for identifying the fertile window.';

  @override
  String get settingsTracking => 'Tracking';

  @override
  String get settingsTempUnit => 'Temperature Unit';

  @override
  String get settingsRuleset => 'STM Ruleset';

  @override
  String get settingsCervix => 'Cervix tracking';

  @override
  String get settingsCervixSub => 'Position, openness & firmness';

  @override
  String get settingsIntercourse => 'Intercourse tracking';

  @override
  String get settingsOpenEntryVia => 'Open day entry via';

  @override
  String get tapLongPress => 'Long press';

  @override
  String get tapDoubleTap => 'Double tap';

  @override
  String get settingsAutoDetection => 'Automatic Detection';

  @override
  String get settingsAutoCoverline => 'Auto-detect coverline';

  @override
  String get settingsAutoCoverlineSub => '3-over-6 rule';

  @override
  String get settingsAutoPeak => 'Auto-detect Peak Day';

  @override
  String get settingsAutoPeakSub => 'From mucus pattern';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsDailyReminder => 'Daily check-in reminder';

  @override
  String get settingsDailyReminderSub =>
      'A single notification each day to log BBT and mucus.';

  @override
  String get settingsReminderTime => 'Reminder time';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExport => 'Export data (CSV)';

  @override
  String get settingsExportSub => 'Save all data as CSV';

  @override
  String get settingsImport => 'Import data (CSV)';

  @override
  String get settingsImportSub => 'Import Ember CSV format';

  @override
  String get settingsImportKindara => 'Import from Kindara';

  @override
  String get settingsImportKindaraSub => 'Import Kindara export file';

  @override
  String get settingsDeleteAll => 'Delete all data';

  @override
  String get settingsDeleteAllSub => 'This cannot be undone';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacySub =>
      'All data stored locally. No account required.';

  @override
  String get settingsAboutStm => 'About STM';

  @override
  String get settingsAboutStmSub =>
      'Compatible with the symptothermal method. Independent app, not affiliated with any organization.';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSupportDev => 'Support development';

  @override
  String get settingsSupportDevSub =>
      'Ember is free. Chip in a coffee if you like — optional.';

  @override
  String get exportCompleteTitle => 'Export Complete';

  @override
  String exportCompleteBody(String path) {
    return 'File saved to:\n$path\n\nWould you like to share it?';
  }

  @override
  String get close => 'Close';

  @override
  String get share => 'Share';

  @override
  String exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String importedEntries(int count) {
    return 'Imported $count entries';
  }

  @override
  String importFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String importedKindara(int count) {
    return 'Imported $count Kindara entries';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Kindara import failed: $error';
  }

  @override
  String get deleteAllTitle => 'Delete All Data?';

  @override
  String get deleteAllBody =>
      'This will permanently delete all your cycles and entries. Consider exporting your data first.\n\nThis action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get allDataDeleted => 'All data deleted';
}
