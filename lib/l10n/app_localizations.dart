import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pl'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ember'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navChart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get navChart;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Ember'**
  String get supportTitle;

  /// No description provided for @supportHeadline.
  ///
  /// In en, this message translates to:
  /// **'Ember is free — and stays that way'**
  String get supportHeadline;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions, no ads, no tracking. Every feature is available to everyone. It’s built and maintained in my spare time.\n\nIf Ember is useful to you and you’d like to chip in toward its development, you can leave a small tip. It’s entirely optional and unlocks nothing — you already have the whole app.'**
  String get supportBody;

  /// No description provided for @supportButton.
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee'**
  String get supportButton;

  /// No description provided for @supportFootnote.
  ///
  /// In en, this message translates to:
  /// **'Opens in your browser. Ember never sees your payment details.'**
  String get supportFootnote;

  /// No description provided for @supportLinkError.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link'**
  String get supportLinkError;

  /// No description provided for @settingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get settingsGoal;

  /// No description provided for @settingsUseFor.
  ///
  /// In en, this message translates to:
  /// **'I use STM for'**
  String get settingsUseFor;

  /// No description provided for @purposeAvoiding.
  ///
  /// In en, this message translates to:
  /// **'Avoiding'**
  String get purposeAvoiding;

  /// No description provided for @purposeAchieving.
  ///
  /// In en, this message translates to:
  /// **'Achieving'**
  String get purposeAchieving;

  /// No description provided for @purposeAvoidingDesc.
  ///
  /// In en, this message translates to:
  /// **'Labels reflect a cautious approach — only confirmed phases are marked infertile.'**
  String get purposeAvoidingDesc;

  /// No description provided for @purposeAchievingDesc.
  ///
  /// In en, this message translates to:
  /// **'Labels use standard STM terminology for identifying the fertile window.'**
  String get purposeAchievingDesc;

  /// No description provided for @settingsTracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get settingsTracking;

  /// No description provided for @settingsTempUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get settingsTempUnit;

  /// No description provided for @settingsRuleset.
  ///
  /// In en, this message translates to:
  /// **'STM Ruleset'**
  String get settingsRuleset;

  /// No description provided for @settingsCervix.
  ///
  /// In en, this message translates to:
  /// **'Cervix tracking'**
  String get settingsCervix;

  /// No description provided for @settingsCervixSub.
  ///
  /// In en, this message translates to:
  /// **'Position, openness & firmness'**
  String get settingsCervixSub;

  /// No description provided for @settingsIntercourse.
  ///
  /// In en, this message translates to:
  /// **'Intercourse tracking'**
  String get settingsIntercourse;

  /// No description provided for @settingsOpenEntryVia.
  ///
  /// In en, this message translates to:
  /// **'Open day entry via'**
  String get settingsOpenEntryVia;

  /// No description provided for @tapLongPress.
  ///
  /// In en, this message translates to:
  /// **'Long press'**
  String get tapLongPress;

  /// No description provided for @tapDoubleTap.
  ///
  /// In en, this message translates to:
  /// **'Double tap'**
  String get tapDoubleTap;

  /// No description provided for @settingsAutoDetection.
  ///
  /// In en, this message translates to:
  /// **'Automatic Detection'**
  String get settingsAutoDetection;

  /// No description provided for @settingsAutoCoverline.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect coverline'**
  String get settingsAutoCoverline;

  /// No description provided for @settingsAutoCoverlineSub.
  ///
  /// In en, this message translates to:
  /// **'3-over-6 rule'**
  String get settingsAutoCoverlineSub;

  /// No description provided for @settingsAutoPeak.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect Peak Day'**
  String get settingsAutoPeak;

  /// No description provided for @settingsAutoPeakSub.
  ///
  /// In en, this message translates to:
  /// **'From mucus pattern'**
  String get settingsAutoPeakSub;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsDailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in reminder'**
  String get settingsDailyReminder;

  /// No description provided for @settingsDailyReminderSub.
  ///
  /// In en, this message translates to:
  /// **'A single notification each day to log BBT and mucus.'**
  String get settingsDailyReminderSub;

  /// No description provided for @settingsReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTime;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export data (CSV)'**
  String get settingsExport;

  /// No description provided for @settingsExportSub.
  ///
  /// In en, this message translates to:
  /// **'Save all data as CSV'**
  String get settingsExportSub;

  /// No description provided for @settingsImport.
  ///
  /// In en, this message translates to:
  /// **'Import data (CSV)'**
  String get settingsImport;

  /// No description provided for @settingsImportSub.
  ///
  /// In en, this message translates to:
  /// **'Import Ember CSV format'**
  String get settingsImportSub;

  /// No description provided for @settingsImportKindara.
  ///
  /// In en, this message translates to:
  /// **'Import from Kindara'**
  String get settingsImportKindara;

  /// No description provided for @settingsImportKindaraSub.
  ///
  /// In en, this message translates to:
  /// **'Import Kindara export file'**
  String get settingsImportKindaraSub;

  /// No description provided for @settingsDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteAll;

  /// No description provided for @settingsDeleteAllSub.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone'**
  String get settingsDeleteAllSub;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacySub.
  ///
  /// In en, this message translates to:
  /// **'All data stored locally. No account required.'**
  String get settingsPrivacySub;

  /// No description provided for @settingsAboutStm.
  ///
  /// In en, this message translates to:
  /// **'About STM'**
  String get settingsAboutStm;

  /// No description provided for @settingsAboutStmSub.
  ///
  /// In en, this message translates to:
  /// **'Compatible with the symptothermal method. Independent app, not affiliated with any organization.'**
  String get settingsAboutStmSub;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsSupportDev.
  ///
  /// In en, this message translates to:
  /// **'Support development'**
  String get settingsSupportDev;

  /// No description provided for @settingsSupportDevSub.
  ///
  /// In en, this message translates to:
  /// **'Ember is free. Chip in a coffee if you like — optional.'**
  String get settingsSupportDevSub;

  /// No description provided for @exportCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Complete'**
  String get exportCompleteTitle;

  /// No description provided for @exportCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'File saved to:\n{path}\n\nWould you like to share it?'**
  String exportCompleteBody(String path);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportFailed(String error);

  /// No description provided for @importedEntries.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} entries'**
  String importedEntries(int count);

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(String error);

  /// No description provided for @importedKindara.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} Kindara entries'**
  String importedKindara(int count);

  /// No description provided for @kindaraImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Kindara import failed: {error}'**
  String kindaraImportFailed(String error);

  /// No description provided for @deleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data?'**
  String get deleteAllTitle;

  /// No description provided for @deleteAllBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your cycles and entries. Consider exporting your data first.\n\nThis action cannot be undone.'**
  String get deleteAllBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteEverything.
  ///
  /// In en, this message translates to:
  /// **'Delete Everything'**
  String get deleteEverything;

  /// No description provided for @allDataDeleted.
  ///
  /// In en, this message translates to:
  /// **'All data deleted'**
  String get allDataDeleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'pl',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
