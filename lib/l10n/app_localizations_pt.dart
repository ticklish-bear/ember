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
}
