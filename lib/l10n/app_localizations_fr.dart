// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Aujourd’hui';

  @override
  String get navChart => 'Courbe';

  @override
  String get navInsights => 'Statistiques';

  @override
  String get navLearn => 'Apprendre';

  @override
  String get navSettings => 'Réglages';

  @override
  String get supportTitle => 'Soutenir Ember';

  @override
  String get supportHeadline => 'Ember est gratuit — et le reste';

  @override
  String get supportBody =>
      'Pas d’abonnement, pas de publicité, pas de suivi. Toutes les fonctions sont accessibles à tous. Je le développe et l’entretiens sur mon temps libre.\n\nSi Ember vous est utile et que vous souhaitez soutenir son développement, vous pouvez laisser un petit pourboire. C’est entièrement facultatif et ne débloque rien : vous avez déjà toute l’application.';

  @override
  String get supportButton => 'Offrez-moi un café';

  @override
  String get supportFootnote =>
      'S’ouvre dans votre navigateur. Ember ne voit jamais vos données de paiement.';

  @override
  String get supportLinkError => 'Impossible d’ouvrir le lien';
}
