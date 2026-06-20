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

  @override
  String get settingsGoal => 'Objetivo';

  @override
  String get settingsUseFor => 'Uso el método para';

  @override
  String get purposeAvoiding => 'Evitar';

  @override
  String get purposeAchieving => 'Buscar';

  @override
  String get purposeAvoidingDesc =>
      'Las etiquetas reflejan un enfoque cauteloso: solo las fases confirmadas se marcan como infértiles.';

  @override
  String get purposeAchievingDesc =>
      'Las etiquetas usan la terminología estándar del método para identificar la ventana fértil.';

  @override
  String get settingsTracking => 'Registro';

  @override
  String get settingsTempUnit => 'Unidad de temperatura';

  @override
  String get settingsRuleset => 'Reglas del método';

  @override
  String get settingsCervix => 'Registrar cuello uterino';

  @override
  String get settingsCervixSub => 'Posición, apertura y firmeza';

  @override
  String get settingsIntercourse => 'Registrar relaciones';

  @override
  String get settingsOpenEntryVia => 'Abrir el registro del día con';

  @override
  String get tapLongPress => 'Mantener pulsado';

  @override
  String get tapDoubleTap => 'Doble toque';

  @override
  String get settingsAutoDetection => 'Detección automática';

  @override
  String get settingsAutoCoverline => 'Línea base automática';

  @override
  String get settingsAutoCoverlineSub => 'Regla 3 sobre 6';

  @override
  String get settingsAutoPeak => 'Día cúspide automático';

  @override
  String get settingsAutoPeakSub => 'A partir del patrón del moco';

  @override
  String get settingsReminders => 'Recordatorios';

  @override
  String get settingsDailyReminder => 'Recordatorio diario';

  @override
  String get settingsDailyReminderSub =>
      'Una notificación al día para registrar temperatura y moco.';

  @override
  String get settingsReminderTime => 'Hora del recordatorio';

  @override
  String get settingsData => 'Datos';

  @override
  String get settingsExport => 'Exportar datos (CSV)';

  @override
  String get settingsExportSub => 'Guardar todos los datos como CSV';

  @override
  String get settingsImport => 'Importar datos (CSV)';

  @override
  String get settingsImportSub => 'Importar formato CSV de Ember';

  @override
  String get settingsImportKindara => 'Importar desde Kindara';

  @override
  String get settingsImportKindaraSub =>
      'Importar archivo de exportación de Kindara';

  @override
  String get settingsDeleteAll => 'Eliminar todos los datos';

  @override
  String get settingsDeleteAllSub => 'Esto no se puede deshacer';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsPrivacySub =>
      'Todos los datos se guardan localmente. No se requiere cuenta.';

  @override
  String get settingsAboutStm => 'Sobre el método';

  @override
  String get settingsAboutStmSub =>
      'Compatible con el método sintotérmico. App independiente, no afiliada a ninguna organización.';

  @override
  String get settingsSupport => 'Apoyar';

  @override
  String get settingsSupportDev => 'Apoyar el desarrollo';

  @override
  String get settingsSupportDevSub =>
      'Ember es gratis. Invita a un café si quieres: opcional.';

  @override
  String get exportCompleteTitle => 'Exportación completa';

  @override
  String exportCompleteBody(String path) {
    return 'Archivo guardado en:\n$path\n\n¿Quieres compartirlo?';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get share => 'Compartir';

  @override
  String exportFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count registros importados';
  }

  @override
  String importFailed(String error) {
    return 'Error al importar: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count registros de Kindara importados';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Error al importar de Kindara: $error';
  }

  @override
  String get deleteAllTitle => '¿Eliminar todos los datos?';

  @override
  String get deleteAllBody =>
      'Esto eliminará permanentemente todos tus ciclos y registros. Considera exportar tus datos primero.\n\nEsta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteEverything => 'Eliminar todo';

  @override
  String get allDataDeleted => 'Todos los datos eliminados';
}
