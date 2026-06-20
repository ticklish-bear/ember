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
}
