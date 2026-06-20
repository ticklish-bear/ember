// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Dziś';

  @override
  String get navChart => 'Wykres';

  @override
  String get navInsights => 'Statystyki';

  @override
  String get navLearn => 'Naucz się';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String get supportTitle => 'Wesprzyj Ember';

  @override
  String get supportHeadline => 'Ember jest darmowy — i taki zostanie';

  @override
  String get supportBody =>
      'Bez subskrypcji, bez reklam, bez śledzenia. Wszystkie funkcje są dostępne dla każdego. Tworzę i utrzymuję aplikację w wolnym czasie.\n\nJeśli Ember jest dla Ciebie przydatny i chcesz wesprzeć jego rozwój, możesz zostawić mały napiwek. Jest całkowicie dobrowolny i niczego nie odblokowuje — masz już całą aplikację.';

  @override
  String get supportButton => 'Postaw mi kawę';

  @override
  String get supportFootnote =>
      'Otwiera się w przeglądarce. Ember nigdy nie widzi Twoich danych płatności.';

  @override
  String get supportLinkError => 'Nie udało się otworzyć linku';

  @override
  String get settingsGoal => 'Cel';

  @override
  String get settingsUseFor => 'Używam metody, aby';

  @override
  String get purposeAvoiding => 'Unikać';

  @override
  String get purposeAchieving => 'Starać się';

  @override
  String get purposeAvoidingDesc =>
      'Etykiety odzwierciedlają ostrożne podejście — tylko potwierdzone fazy są oznaczane jako niepłodne.';

  @override
  String get purposeAchievingDesc =>
      'Etykiety używają standardowej terminologii metody do określenia okna płodności.';

  @override
  String get settingsTracking => 'Zapis';

  @override
  String get settingsTempUnit => 'Jednostka temperatury';

  @override
  String get settingsRuleset => 'Reguły metody';

  @override
  String get settingsCervix => 'Zapis szyjki macicy';

  @override
  String get settingsCervixSub => 'Pozycja, rozwarcie i twardość';

  @override
  String get settingsIntercourse => 'Zapis współżycia';

  @override
  String get settingsOpenEntryVia => 'Otwórz wpis dnia przez';

  @override
  String get tapLongPress => 'Długie naciśnięcie';

  @override
  String get tapDoubleTap => 'Podwójne dotknięcie';

  @override
  String get settingsAutoDetection => 'Automatyczne wykrywanie';

  @override
  String get settingsAutoCoverline => 'Automatyczna linia bazowa';

  @override
  String get settingsAutoCoverlineSub => 'Reguła 3 ponad 6';

  @override
  String get settingsAutoPeak => 'Automatyczny dzień szczytu';

  @override
  String get settingsAutoPeakSub => 'Na podstawie wzorca śluzu';

  @override
  String get settingsReminders => 'Przypomnienia';

  @override
  String get settingsDailyReminder => 'Codzienne przypomnienie';

  @override
  String get settingsDailyReminderSub =>
      'Jedno powiadomienie dziennie, aby zapisać temperaturę i śluz.';

  @override
  String get settingsReminderTime => 'Godzina przypomnienia';

  @override
  String get settingsData => 'Dane';

  @override
  String get settingsExport => 'Eksportuj dane (CSV)';

  @override
  String get settingsExportSub => 'Zapisz wszystkie dane jako CSV';

  @override
  String get settingsImport => 'Importuj dane (CSV)';

  @override
  String get settingsImportSub => 'Importuj format CSV aplikacji Ember';

  @override
  String get settingsImportKindara => 'Importuj z Kindara';

  @override
  String get settingsImportKindaraSub => 'Importuj plik eksportu Kindara';

  @override
  String get settingsDeleteAll => 'Usuń wszystkie dane';

  @override
  String get settingsDeleteAllSub => 'Tego nie można cofnąć';

  @override
  String get settingsAbout => 'O aplikacji';

  @override
  String get settingsPrivacy => 'Prywatność';

  @override
  String get settingsPrivacySub =>
      'Wszystkie dane przechowywane lokalnie. Konto nie jest wymagane.';

  @override
  String get settingsAboutStm => 'O metodzie';

  @override
  String get settingsAboutStmSub =>
      'Zgodna z metodą objawowo-termiczną. Niezależna aplikacja, niepowiązana z żadną organizacją.';

  @override
  String get settingsSupport => 'Wsparcie';

  @override
  String get settingsSupportDev => 'Wesprzyj rozwój';

  @override
  String get settingsSupportDevSub =>
      'Ember jest darmowy. Postaw kawę, jeśli chcesz — dobrowolnie.';

  @override
  String get exportCompleteTitle => 'Eksport zakończony';

  @override
  String exportCompleteBody(String path) {
    return 'Plik zapisany w:\n$path\n\nCzy chcesz go udostępnić?';
  }

  @override
  String get close => 'Zamknij';

  @override
  String get share => 'Udostępnij';

  @override
  String exportFailed(String error) {
    return 'Eksport nie powiódł się: $error';
  }

  @override
  String importedEntries(int count) {
    return 'Zaimportowano $count wpisów';
  }

  @override
  String importFailed(String error) {
    return 'Import nie powiódł się: $error';
  }

  @override
  String importedKindara(int count) {
    return 'Zaimportowano $count wpisów z Kindara';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Import z Kindara nie powiódł się: $error';
  }

  @override
  String get deleteAllTitle => 'Usunąć wszystkie dane?';

  @override
  String get deleteAllBody =>
      'Spowoduje to trwałe usunięcie wszystkich cykli i wpisów. Rozważ najpierw wyeksportowanie danych.\n\nTej operacji nie można cofnąć.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get deleteEverything => 'Usuń wszystko';

  @override
  String get allDataDeleted => 'Usunięto wszystkie dane';
}
