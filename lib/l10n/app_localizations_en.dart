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
}
