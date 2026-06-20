import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import '../providers/cycle_provider.dart';
import '../models/settings.dart';
import '../database/database_helper.dart';
import '../services/export_import_service.dart';
import '../config/support_links.dart';
import '../l10n/app_localizations.dart';
import 'support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;

    return Consumer<CycleProvider>(
      builder: (context, provider, _) {
        final settings = provider.settings;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // App identity
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.favorite_rounded,
                        color: colors.onPrimaryContainer, size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text('Ember',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Text('v0.1.0',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Purpose
            _sectionTitle(l.settingsGoal, colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.favorite_border,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsUseFor),
                trailing: SegmentedButton<AppPurpose>(
                  segments: [
                    ButtonSegment(
                        value: AppPurpose.anticonception,
                        label: Text(l.purposeAvoiding)),
                    ButtonSegment(
                        value: AppPurpose.conception,
                        label: Text(l.purposeAchieving)),
                  ],
                  selected: {settings.purpose},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        purpose: value.first));
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  settings.purpose == AppPurpose.anticonception
                      ? l.purposeAvoidingDesc
                      : l.purposeAchievingDesc,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 20),

            // Tracking
            _sectionTitle(l.settingsTracking, colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.thermostat_outlined,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsTempUnit),
                trailing: SegmentedButton<TemperatureUnit>(
                  segments: const [
                    ButtonSegment(
                        value: TemperatureUnit.celsius,
                        label: Text('°C')),
                    ButtonSegment(
                        value: TemperatureUnit.fahrenheit,
                        label: Text('°F')),
                  ],
                  selected: {settings.temperatureUnit},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        temperatureUnit: value.first));
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.rule,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsRuleset),
                trailing: SegmentedButton<StmRuleset>(
                  segments: const [
                    ButtonSegment(
                        value: StmRuleset.agNfp,
                        label: Text('AG NFP')),
                    ButtonSegment(
                        value: StmRuleset.tcoyf,
                        label: Text('TCOYF')),
                  ],
                  selected: {settings.ruleset},
                  onSelectionChanged: (value) {
                    provider.updateSettings(
                        settings.copyWith(ruleset: value.first));
                  },
                ),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.adjust,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsCervix),
                subtitle: Text(l.settingsCervixSub),
                value: settings.showCervixTracking,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(showCervixTracking: v)),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.people_outline,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsIntercourse),
                value: settings.showIntercourseTracking,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(
                        showIntercourseTracking: v)),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.touch_app_outlined,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsOpenEntryVia),
                trailing: SegmentedButton<CalendarTapAction>(
                  segments: [
                    ButtonSegment(
                        value: CalendarTapAction.longPress,
                        label: Text(l.tapLongPress)),
                    ButtonSegment(
                        value: CalendarTapAction.doubleTap,
                        label: Text(l.tapDoubleTap)),
                  ],
                  selected: {settings.calendarTapAction},
                  onSelectionChanged: (value) {
                    provider.updateSettings(settings.copyWith(
                        calendarTapAction: value.first));
                  },
                ),
              ),
            ]),
            const SizedBox(height: 20),

            // Automatic Detection
            _sectionTitle(l.settingsAutoDetection, colors),
            _settingsContainer(colors, [
              SwitchListTile(
                secondary: Icon(Icons.auto_graph,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsAutoCoverline),
                subtitle: Text(l.settingsAutoCoverlineSub),
                value: settings.autoDetectCoverline,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(autoDetectCoverline: v)),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(Icons.water_drop_outlined,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsAutoPeak),
                subtitle: Text(l.settingsAutoPeakSub),
                value: settings.autoDetectPeakDay,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(autoDetectPeakDay: v)),
              ),
            ]),
            const SizedBox(height: 20),

            // Reminders
            _sectionTitle(l.settingsReminders, colors),
            _settingsContainer(colors, [
              SwitchListTile(
                secondary: Icon(Icons.notifications_active_outlined,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsDailyReminder),
                subtitle: Text(l.settingsDailyReminderSub),
                value: settings.dailyReminderEnabled,
                onChanged: (v) => provider.updateSettings(
                    settings.copyWith(dailyReminderEnabled: v)),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.schedule,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsReminderTime),
                subtitle: Text(settings.reminderTimeLabel),
                enabled: settings.dailyReminderEnabled,
                onTap: settings.dailyReminderEnabled
                    ? () => _pickReminderTime(context, provider, settings)
                    : null,
                trailing: const Icon(Icons.edit_outlined, size: 18),
              ),
            ]),
            const SizedBox(height: 20),

            // Data
            _sectionTitle(l.settingsData, colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.upload_file_outlined,
                    color: colors.primary),
                title: Text(l.settingsExport),
                subtitle: Text(l.settingsExportSub),
                onTap: () => _exportData(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.download_outlined,
                    color: colors.primary),
                title: Text(l.settingsImport),
                subtitle: Text(l.settingsImportSub),
                onTap: () => _importData(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.swap_horiz,
                    color: colors.primary),
                title: Text(l.settingsImportKindara),
                subtitle: Text(l.settingsImportKindaraSub),
                onTap: () => _importKindara(context),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.delete_outline,
                    color: colors.error),
                title: Text(l.settingsDeleteAll,
                    style: TextStyle(color: colors.error)),
                subtitle: Text(l.settingsDeleteAllSub),
                onTap: () => _confirmDelete(context, provider),
              ),
            ]),
            const SizedBox(height: 20),

            // About
            _sectionTitle(l.settingsAbout, colors),
            _settingsContainer(colors, [
              ListTile(
                leading: Icon(Icons.shield_outlined,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsPrivacy),
                subtitle: Text(l.settingsPrivacySub),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.info_outline,
                    color: colors.onSurfaceVariant),
                title: Text(l.settingsAboutStm),
                subtitle: Text(l.settingsAboutStmSub),
              ),
            ]),

            if (SupportLinks.enabled) ...[
              const SizedBox(height: 20),
              _sectionTitle(l.settingsSupport, colors),
              _settingsContainer(colors, [
                ListTile(
                  leading: Icon(Icons.local_cafe_outlined,
                      color: colors.primary),
                  title: Text(l.settingsSupportDev),
                  subtitle: Text(l.settingsSupportDevSub),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const SupportScreen()),
                  ),
                ),
              ]),
            ],
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.primary,
            letterSpacing: 0.3,
          )),
    );
  }

  Widget _settingsContainer(
      ColorScheme colors, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: colors.outlineVariant.withAlpha(100)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Future<void> _pickReminderTime(BuildContext context,
      CycleProvider provider, AppSettings settings) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.dailyReminderHour,
        minute: settings.dailyReminderMinute,
      ),
    );
    if (picked == null) return;
    await provider.updateSettings(settings.copyWith(
      dailyReminderHour: picked.hour,
      dailyReminderMinute: picked.minute,
    ));
  }

  Future<void> _exportData(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    try {
      final service = ExportImportService();
      final path = await service.exportToCsv();
      if (context.mounted) {
        final result = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.exportCompleteTitle),
            content: Text(l.exportCompleteBody(path)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.close),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.share),
              ),
            ],
          ),
        );
        if (result == true) {
          await Share.shareXFiles([XFile(path)]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.exportFailed(e.toString()))));
      }
    }
  }

  Future<void> _importData(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true);
      if (result == null) return;
      final bytes = result.files.single.bytes;
      if (bytes == null) return;
      final content = utf8.decode(bytes);
      final service = ExportImportService();
      final count = await service.importFromCsv(content);
      if (context.mounted) {
        final provider = context.read<CycleProvider>();
        await provider.loadCycles();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.importedEntries(count))));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.importFailed(e.toString()))));
      }
    }
  }

  Future<void> _importKindara(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true);
      if (result == null) return;
      final bytes = result.files.single.bytes;
      if (bytes == null) return;
      final content = utf8.decode(bytes);
      final service = ExportImportService();
      final count = await service.importFromKindara(content);
      if (context.mounted) {
        final provider = context.read<CycleProvider>();
        await provider.loadCycles();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(l.importedKindara(count))));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(l.kindaraImportFailed(e.toString()))));
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, CycleProvider provider) async {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteAllTitle),
        content: Text(l.deleteAllBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: colors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.deleteEverything),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = DatabaseHelper();
      await db.clearAllData();
      await provider.loadCycles();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.allDataDeleted)));
      }
    }
  }
}
