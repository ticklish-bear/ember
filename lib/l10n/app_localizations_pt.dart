// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Ember';

  @override
  String get navToday => 'Hoje';

  @override
  String get navChart => 'Gráfico';

  @override
  String get navInsights => 'Estatísticas';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get supportTitle => 'Apoiar o Ember';

  @override
  String get supportHeadline => 'O Ember é grátis — e continua assim';

  @override
  String get supportBody =>
      'Sem assinaturas, sem anúncios, sem rastreamento. Todos os recursos estão disponíveis para todos. É desenvolvido e mantido no meu tempo livre.\n\nSe o Ember é útil para você e quiser apoiar o desenvolvimento, pode deixar uma pequena contribuição. É totalmente opcional e não desbloqueia nada — você já tem o app completo.';

  @override
  String get supportButton => 'Pague-me um café';

  @override
  String get supportFootnote =>
      'Abre no seu navegador. O Ember nunca vê os seus dados de pagamento.';

  @override
  String get supportLinkError => 'Não foi possível abrir o link';

  @override
  String get settingsGoal => 'Objetivo';

  @override
  String get settingsUseFor => 'Uso o método para';

  @override
  String get purposeAvoiding => 'Evitar';

  @override
  String get purposeAchieving => 'Buscar';

  @override
  String get purposeAvoidingDesc =>
      'Os rótulos refletem uma abordagem cautelosa: apenas as fases confirmadas são marcadas como inférteis.';

  @override
  String get purposeAchievingDesc =>
      'Os rótulos usam a terminologia padrão do método para identificar a janela fértil.';

  @override
  String get settingsTracking => 'Registro';

  @override
  String get settingsTempUnit => 'Unidade de temperatura';

  @override
  String get settingsRuleset => 'Regras do método';

  @override
  String get settingsCervix => 'Registrar colo do útero';

  @override
  String get settingsCervixSub => 'Posição, abertura e firmeza';

  @override
  String get settingsIntercourse => 'Registrar relações';

  @override
  String get settingsOpenEntryVia => 'Abrir o registro do dia com';

  @override
  String get tapLongPress => 'Pressionar e segurar';

  @override
  String get tapDoubleTap => 'Toque duplo';

  @override
  String get settingsAutoDetection => 'Detecção automática';

  @override
  String get settingsAutoCoverline => 'Linha de base automática';

  @override
  String get settingsAutoCoverlineSub => 'Regra 3 sobre 6';

  @override
  String get settingsAutoPeak => 'Dia ápice automático';

  @override
  String get settingsAutoPeakSub => 'A partir do padrão do muco';

  @override
  String get settingsReminders => 'Lembretes';

  @override
  String get settingsDailyReminder => 'Lembrete diário';

  @override
  String get settingsDailyReminderSub =>
      'Uma notificação por dia para registrar temperatura e muco.';

  @override
  String get settingsReminderTime => 'Horário do lembrete';

  @override
  String get settingsData => 'Dados';

  @override
  String get settingsExport => 'Exportar dados (CSV)';

  @override
  String get settingsExportSub => 'Salvar todos os dados como CSV';

  @override
  String get settingsImport => 'Importar dados (CSV)';

  @override
  String get settingsImportSub => 'Importar formato CSV do Ember';

  @override
  String get settingsImportKindara => 'Importar do Kindara';

  @override
  String get settingsImportKindaraSub =>
      'Importar arquivo de exportação do Kindara';

  @override
  String get settingsDeleteAll => 'Excluir todos os dados';

  @override
  String get settingsDeleteAllSub => 'Isto não pode ser desfeito';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsPrivacySub =>
      'Todos os dados são salvos localmente. Não é necessária conta.';

  @override
  String get settingsAboutStm => 'Sobre o método';

  @override
  String get settingsAboutStmSub =>
      'Compatível com o método sintotérmico. App independente, não afiliado a nenhuma organização.';

  @override
  String get settingsSupport => 'Apoiar';

  @override
  String get settingsSupportDev => 'Apoiar o desenvolvimento';

  @override
  String get settingsSupportDevSub =>
      'O Ember é grátis. Pague um café se quiser — opcional.';

  @override
  String get exportCompleteTitle => 'Exportação concluída';

  @override
  String exportCompleteBody(String path) {
    return 'Arquivo salvo em:\n$path\n\nDeseja compartilhá-lo?';
  }

  @override
  String get close => 'Fechar';

  @override
  String get share => 'Compartilhar';

  @override
  String exportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String importedEntries(int count) {
    return '$count registros importados';
  }

  @override
  String importFailed(String error) {
    return 'Falha na importação: $error';
  }

  @override
  String importedKindara(int count) {
    return '$count registros do Kindara importados';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Falha ao importar do Kindara: $error';
  }

  @override
  String get deleteAllTitle => 'Excluir todos os dados?';

  @override
  String get deleteAllBody =>
      'Isto excluirá permanentemente todos os seus ciclos e registros. Considere exportar seus dados primeiro.\n\nEsta ação não pode ser desfeita.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteEverything => 'Excluir tudo';

  @override
  String get allDataDeleted => 'Todos os dados excluídos';
}
