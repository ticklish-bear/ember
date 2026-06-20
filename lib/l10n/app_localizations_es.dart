// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Hoy';

  @override
  String get navChart => 'Gráfica';

  @override
  String get navInsights => 'Estadísticas';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get supportTitle => 'Apoyar Ember';

  @override
  String get supportHeadline => 'Ember es gratis, y seguirá siéndolo';

  @override
  String get supportBody =>
      'Sin suscripciones, sin anuncios, sin rastreo. Todas las funciones están disponibles para todo el mundo. La desarrollo y mantengo en mi tiempo libre.\n\nSi Ember te resulta útil y quieres apoyar su desarrollo, puedes dejar una pequeña propina. Es totalmente opcional y no desbloquea nada: ya tienes la app completa.';

  @override
  String get supportButton => 'Invítame a un café';

  @override
  String get supportFootnote =>
      'Se abre en tu navegador. Ember nunca ve tus datos de pago.';

  @override
  String get supportLinkError => 'No se pudo abrir el enlace';
}
