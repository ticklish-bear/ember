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

  @override
  String get settingsGoal => 'Objectif';

  @override
  String get settingsUseFor => 'J’utilise la méthode pour';

  @override
  String get purposeAvoiding => 'Éviter';

  @override
  String get purposeAchieving => 'Concevoir';

  @override
  String get purposeAvoidingDesc =>
      'Les libellés adoptent une approche prudente : seules les phases confirmées sont marquées comme infertiles.';

  @override
  String get purposeAchievingDesc =>
      'Les libellés utilisent la terminologie standard de la méthode pour identifier la fenêtre fertile.';

  @override
  String get settingsTracking => 'Saisie';

  @override
  String get settingsTempUnit => 'Unité de température';

  @override
  String get settingsRuleset => 'Règles de la méthode';

  @override
  String get settingsCervix => 'Suivi du col de l’utérus';

  @override
  String get settingsCervixSub => 'Position, ouverture et fermeté';

  @override
  String get settingsIntercourse => 'Suivi des rapports';

  @override
  String get settingsOpenEntryVia => 'Ouvrir la saisie du jour par';

  @override
  String get tapLongPress => 'Appui long';

  @override
  String get tapDoubleTap => 'Double tape';

  @override
  String get settingsAutoDetection => 'Détection automatique';

  @override
  String get settingsAutoCoverline => 'Ligne de base automatique';

  @override
  String get settingsAutoCoverlineSub => 'Règle des 3 au-dessus de 6';

  @override
  String get settingsAutoPeak => 'Jour sommet automatique';

  @override
  String get settingsAutoPeakSub => 'À partir du profil de la glaire';

  @override
  String get settingsReminders => 'Rappels';

  @override
  String get settingsDailyReminder => 'Rappel quotidien';

  @override
  String get settingsDailyReminderSub =>
      'Une notification par jour pour noter température et glaire.';

  @override
  String get settingsReminderTime => 'Heure du rappel';

  @override
  String get settingsData => 'Données';

  @override
  String get settingsExport => 'Exporter les données (CSV)';

  @override
  String get settingsExportSub => 'Enregistrer toutes les données en CSV';

  @override
  String get settingsImport => 'Importer des données (CSV)';

  @override
  String get settingsImportSub => 'Importer le format CSV d’Ember';

  @override
  String get settingsImportKindara => 'Importer depuis Kindara';

  @override
  String get settingsImportKindaraSub => 'Importer un fichier d’export Kindara';

  @override
  String get settingsDeleteAll => 'Supprimer toutes les données';

  @override
  String get settingsDeleteAllSub => 'Cette action est irréversible';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacySub =>
      'Toutes les données sont stockées localement. Aucun compte requis.';

  @override
  String get settingsAboutStm => 'À propos de la méthode';

  @override
  String get settingsAboutStmSub =>
      'Compatible avec la méthode symptothermique. Application indépendante, non affiliée à aucune organisation.';

  @override
  String get settingsSupport => 'Soutenir';

  @override
  String get settingsSupportDev => 'Soutenir le développement';

  @override
  String get settingsSupportDevSub =>
      'Ember est gratuit. Offrez un café si vous voulez — facultatif.';

  @override
  String get exportCompleteTitle => 'Export terminé';

  @override
  String exportCompleteBody(String path) {
    return 'Fichier enregistré dans :\n$path\n\nVoulez-vous le partager ?';
  }

  @override
  String get close => 'Fermer';

  @override
  String get share => 'Partager';

  @override
  String exportFailed(String error) {
    return 'Échec de l’export : $error';
  }

  @override
  String importedEntries(int count) {
    return '$count entrées importées';
  }

  @override
  String importFailed(String error) {
    return 'Échec de l’import : $error';
  }

  @override
  String importedKindara(int count) {
    return '$count entrées Kindara importées';
  }

  @override
  String kindaraImportFailed(String error) {
    return 'Échec de l’import Kindara : $error';
  }

  @override
  String get deleteAllTitle => 'Supprimer toutes les données ?';

  @override
  String get deleteAllBody =>
      'Cela supprimera définitivement tous vos cycles et saisies. Pensez à exporter vos données d’abord.\n\nCette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get deleteEverything => 'Tout supprimer';

  @override
  String get allDataDeleted => 'Toutes les données supprimées';

  @override
  String cycleDayLabel(int day) {
    return 'Jour du cycle $day';
  }

  @override
  String get deleteEntryTooltip => 'Supprimer la saisie';

  @override
  String get sectionTemperature => 'Température';

  @override
  String bbtLabel(String unit) {
    return 'TBC ($unit)';
  }

  @override
  String get fieldTime => 'Heure';

  @override
  String get disturbanceFactorsLabel => 'Facteurs perturbateurs';

  @override
  String get disturbanceHelp =>
      'Quelque chose d\'inhabituel a-t-il affecté votre température ? Les valeurs marquées apparaissent sur la courbe mais sont exclues du calcul de la ligne de base.';

  @override
  String get distIllness => 'Maladie';

  @override
  String get distPoorSleep => 'Mauvais sommeil';

  @override
  String get distAlcohol => 'Alcool';

  @override
  String get distLateMeasurement => 'Mesure tardive';

  @override
  String get distStress => 'Stress';

  @override
  String get distTravel => 'Voyage';

  @override
  String get distMedication => 'Médicament';

  @override
  String get additionalDetails => 'Détails supplémentaires (facultatif)';

  @override
  String get additionalDetailsHint => 'p. ex. réveil 2 h plus tard';

  @override
  String get sectionMucus => 'Glaire cervicale';

  @override
  String get mucusSensation => 'Sensation';

  @override
  String get mucusAppearanceLabel => 'Aspect';

  @override
  String get mucusDry => 'Sèche';

  @override
  String get mucusNothing => 'Rien';

  @override
  String get mucusMoist => 'Humide';

  @override
  String get mucusWet => 'Mouillée';

  @override
  String get mucusSlippery => 'Glissante';

  @override
  String get mucusEggWhite => 'Blanc d\'œuf';

  @override
  String get mucusNotRecorded => 'Non renseignée';

  @override
  String get appNone => 'Aucun';

  @override
  String get appCloudy => 'Trouble';

  @override
  String get appYellowish => 'Jaunâtre';

  @override
  String get appSticky => 'Collante';

  @override
  String get appCreamy => 'Crémeuse';

  @override
  String get appClear => 'Claire';

  @override
  String get appStretchy => 'Élastique';

  @override
  String get appTransparent => 'Transparente';

  @override
  String get sectionBleeding => 'Saignement';

  @override
  String get bleedNone => 'Aucun';

  @override
  String get bleedSpotting => 'Spotting';

  @override
  String get bleedLight => 'Léger';

  @override
  String get bleedMedium => 'Moyen';

  @override
  String get bleedHeavy => 'Abondant';

  @override
  String get sectionCervix => 'Col de l\'utérus';

  @override
  String get cervixPositionLabel => 'Position';

  @override
  String get cervixOpennessLabel => 'Ouverture';

  @override
  String get cervixFirmnessLabel => 'Fermeté';

  @override
  String get posLow => 'Bas';

  @override
  String get posMedium => 'Moyen';

  @override
  String get posHigh => 'Haut';

  @override
  String get openClosed => 'Fermé';

  @override
  String get openPartially => 'Entrouvert';

  @override
  String get openOpen => 'Ouvert';

  @override
  String get firmFirm => 'Ferme';

  @override
  String get firmMedium => 'Moyen';

  @override
  String get firmSoft => 'Souple';

  @override
  String get sectionAdditional => 'Autre';

  @override
  String get fieldIntercourse => 'Rapports';

  @override
  String get markPeakDay => 'Marquer comme jour sommet';

  @override
  String get markPeakDaySub =>
      'Dernier jour de la meilleure glaire avant l\'assèchement';

  @override
  String get sectionNotes => 'Notes';

  @override
  String get notesHint => 'Autres observations...';

  @override
  String get saveEntry => 'Enregistrer';

  @override
  String get couldNotLoad => 'Impossible de charger la saisie';

  @override
  String get goBack => 'Retour';

  @override
  String get unsavedTitle => 'Modifications non enregistrées';

  @override
  String get unsavedBody =>
      'Vous avez des modifications non enregistrées. Les abandonner ?';

  @override
  String get keepEditing => 'Continuer l\'édition';

  @override
  String get discard => 'Abandonner';

  @override
  String get invalidNumber => 'Saisissez un nombre valide';

  @override
  String get rangeCelsius => 'Plage attendue : 35,00 - 39,00 °C';

  @override
  String get rangeFahrenheit => 'Plage attendue : 95,00 - 102,20 °F';

  @override
  String get deleteEntryTitle => 'Supprimer la saisie ?';

  @override
  String deleteEntryBody(String date, int day) {
    return 'Supprimer la saisie du $date (jour du cycle $day) ?\n\nCette action est irréversible.';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get entryDeleted => 'Saisie supprimée';

  @override
  String get entrySaved => 'Saisie enregistrée';
}
