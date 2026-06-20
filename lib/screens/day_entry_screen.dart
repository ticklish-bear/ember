import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/cycle_provider.dart';
import '../models/day_entry.dart';
import '../models/settings.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class DayEntryScreen extends StatefulWidget {
  final DateTime date;

  const DayEntryScreen({super.key, required this.date});

  @override
  State<DayEntryScreen> createState() => _DayEntryScreenState();
}

class _DayEntryScreenState extends State<DayEntryScreen> {
  DayEntry? _entry;
  DayEntry? _originalEntry; // For unsaved changes detection
  bool _isLoading = true;
  bool _hasUnsavedChanges = false;
  final _tempController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  final _excludeReasonController = TextEditingController();
  String? _tempError;

  // Common disturbance factors for temperature
  static const _disturbanceFactors = [
    'Illness',
    'Poor sleep',
    'Alcohol',
    'Late measurement',
    'Stress',
    'Travel',
    'Medication',
  ];
  final Set<String> _selectedDisturbances = {};

  @override
  void initState() {
    super.initState();
    _loadEntry();
    // Listen for text changes to track unsaved state
    _tempController.addListener(_markDirty);
    _timeController.addListener(_markDirty);
    _notesController.addListener(_markDirty);
    _excludeReasonController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_hasUnsavedChanges && !_isLoading) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  /// Parse the stored reason string back into selected chips + free text.
  /// Format: "Illness, Poor sleep | woke up 2h late"
  void _parseDisturbancesFromReason(String? reason) {
    _selectedDisturbances.clear();
    _excludeReasonController.text = '';
    if (reason == null || reason.isEmpty) return;

    // Split on pipe separator between chips and free text
    final parts = reason.split(' | ');
    final chipsPart = parts[0];
    final freeText = parts.length > 1 ? parts.sublist(1).join(' | ') : '';

    // Match known factors
    for (final factor in _disturbanceFactors) {
      if (chipsPart.contains(factor)) {
        _selectedDisturbances.add(factor);
      }
    }

    // If there were unknown parts in chips section, or free text
    _excludeReasonController.text = freeText;

    // If nothing matched any known factor, put it all in free text
    if (_selectedDisturbances.isEmpty && freeText.isEmpty) {
      _excludeReasonController.text = reason;
    }
  }

  /// Sync selected disturbance chips to the controller for storage.
  void _syncDisturbancesToController() {
    // We don't store in the controller — we build the string at save time
  }

  /// Build the combined reason string from chips + free text.
  String? _buildReasonString() {
    if (_selectedDisturbances.isEmpty &&
        _excludeReasonController.text.isEmpty) {
      return null;
    }
    final chips = _selectedDisturbances.toList()..sort();
    final freeText = _excludeReasonController.text.trim();
    if (chips.isEmpty) return freeText.isNotEmpty ? freeText : null;
    if (freeText.isEmpty) return chips.join(', ');
    return '${chips.join(', ')} | $freeText';
  }

  Future<void> _loadEntry() async {
    try {
      final provider = context.read<CycleProvider>();
      final entry = await provider.getOrCreateEntry(widget.date);
      if (!mounted) return;
      setState(() {
        _entry = entry;
        _originalEntry = entry;
        _isLoading = false;
        if (entry.temperature != null) {
          _tempController.text = provider.settings
              .displayTemp(entry.temperature!)
              .toStringAsFixed(2);
        }
        _timeController.text = entry.temperatureTime ?? '';
        _notesController.text = entry.notes ?? '';
        // Parse stored disturbance factors from reason string
        _parseDisturbancesFromReason(entry.temperatureExcludeReason);
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _entry = DayEntry(
            cycleId: 0,
            date: DateTime(widget.date.year, widget.date.month, widget.date.day),
            cycleDay: 1,
          );
          _originalEntry = _entry;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tempController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    _excludeReasonController.dispose();
    super.dispose();
  }

  /// Check if the entry has been modified
  bool get _isDirty {
    if (_entry == null || _originalEntry == null) return false;
    final e = _entry!;
    final o = _originalEntry!;
    return _hasUnsavedChanges ||
        e.mucusType != o.mucusType ||
        e.mucusAppearance != o.mucusAppearance ||
        e.bleeding != o.bleeding ||
        e.temperatureExcluded != o.temperatureExcluded ||
        e.cervixPosition != o.cervixPosition ||
        e.cervixOpenness != o.cervixOpenness ||
        e.cervixFirmness != o.cervixFirmness ||
        e.isPeakDay != o.isPeakDay ||
        e.intercourse != o.intercourse;
  }

  Future<bool> _onWillPop() async {
    if (!_isDirty) return true;
    final l = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.unsavedTitle),
        content: Text(l.unsavedBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.keepEditing),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.discard),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateLabel = DateFormat('EEE, MMM d', locale).format(widget.date);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(dateLabel),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final entry = _entry;
    if (entry == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(dateLabel),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: colors.error),
              const SizedBox(height: 16),
              Text(l.couldNotLoad),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l.goBack),
              ),
            ],
          ),
        ),
      );
    }

    final provider = context.watch<CycleProvider>();
    final settings = provider.settings;

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateLabel),
              Text(
                l.cycleDayLabel(entry.cycleDay),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          actions: [
            // Delete button — only for existing (saved) entries
            if (entry.id != null)
              IconButton(
                icon: Icon(Icons.delete_outline, color: colors.error),
                tooltip: l.deleteEntryTooltip,
                onPressed: () => _confirmDelete(context, provider, entry),
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            // Temperature
            _buildSection(
              title: l.sectionTemperature,
              icon: Icons.thermostat_outlined,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _tempController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: l.bbtLabel(settings.tempUnitLabel),
                          hintText:
                              settings.temperatureUnit == TemperatureUnit.celsius
                                  ? '36.50'
                                  : '97.70',
                          errorText: _tempError,
                          suffixIcon: _tempController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _tempController.clear();
                                    setState(() => _tempError = null);
                                  },
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _tempError = _validateTemperature(value, settings);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          labelText: l.fieldTime,
                          hintText: '06:30',
                        ),
                        onTap: _pickTime,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Disturbance factors
                _subLabel(l.disturbanceFactorsLabel, colors),
                const SizedBox(height: 4),
                Text(
                  l.disturbanceHelp,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _disturbanceFactors.map((factor) {
                    final isSelected =
                        _selectedDisturbances.contains(factor);
                    return FilterChip(
                      label: Text(_disturbanceLabel(factor, l)),
                      selected: isSelected,
                      selectedColor: colors.errorContainer,
                      checkmarkColor: colors.onErrorContainer,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDisturbances.add(factor);
                          } else {
                            _selectedDisturbances.remove(factor);
                          }
                          // Auto-exclude temp when any disturbance is tagged
                          _entry = entry.copyWith(
                            temperatureExcluded:
                                _selectedDisturbances.isNotEmpty,
                          );
                          _hasUnsavedChanges = true;
                          _syncDisturbancesToController();
                        });
                      },
                    );
                  }).toList(),
                ),
                // Custom reason field (always visible, for "Other" or details)
                if (_selectedDisturbances.isNotEmpty ||
                    _excludeReasonController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _excludeReasonController,
                      decoration: InputDecoration(
                        labelText: l.additionalDetails,
                        hintText: l.additionalDetailsHint,
                      ),
                    ),
                  ),
              ],
            ),

            // Cervical mucus
            _buildSection(
              title: l.sectionMucus,
              icon: Icons.water_drop_outlined,
              children: [
                _subLabel(l.mucusSensation, colors),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MucusType.values
                      .where((t) => t != MucusType.unrecorded)
                      .map((type) {
                    return ChoiceChip(
                      label: Text(_mucusTypeLabel(type)),
                      selected: entry.mucusType == type,
                      selectedColor: AppTheme.mucusColor(
                          MucusType.values.indexOf(type)),
                      onSelected: (selected) {
                        setState(() {
                          _entry = entry.copyWith(
                            mucusType: selected
                                ? type
                                : MucusType.unrecorded,
                          );
                          _hasUnsavedChanges = true;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                _subLabel(l.mucusAppearanceLabel, colors),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MucusAppearance.values.map((app) {
                    return ChoiceChip(
                      label: Text(_mucusAppLabel(app)),
                      selected: entry.mucusAppearance == app,
                      onSelected: (selected) {
                        setState(() {
                          _entry = entry.copyWith(
                            mucusAppearance: selected
                                ? app
                                : MucusAppearance.none,
                          );
                          _hasUnsavedChanges = true;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),

            // Bleeding
            _buildSection(
              title: l.sectionBleeding,
              icon: Icons.circle,
              iconColor: AppColors.menstruation,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: BleedingType.values.map((type) {
                    return ChoiceChip(
                      label: Text(_bleedingLabel(type)),
                      selected: entry.bleeding == type,
                      selectedColor: type != BleedingType.none
                          ? AppColors.menstruation.withAlpha(60)
                          : null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _entry = entry.copyWith(bleeding: type);
                            _hasUnsavedChanges = true;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),

            // Cervix (optional)
            if (settings.showCervixTracking)
              _buildSection(
                title: l.sectionCervix,
                icon: Icons.adjust,
                children: [
                  _subLabel(l.cervixPositionLabel, colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixPosition.values
                        .where((p) => p != CervixPosition.unset)
                        .map((pos) => ChoiceChip(
                              label: Text(_cervixPositionLabel(pos)),
                              selected: entry.cervixPosition == pos,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixPosition: s
                                          ? pos
                                          : CervixPosition.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _subLabel(l.cervixOpennessLabel, colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixOpenness.values
                        .where((o) => o != CervixOpenness.unset)
                        .map((op) => ChoiceChip(
                              label: Text(_cervixOpennessLabel(op)),
                              selected: entry.cervixOpenness == op,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixOpenness: s
                                          ? op
                                          : CervixOpenness.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _subLabel(l.cervixFirmnessLabel, colors),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CervixFirmness.values
                        .where((f) => f != CervixFirmness.unset)
                        .map((firm) => ChoiceChip(
                              label: Text(_cervixFirmnessLabel(firm)),
                              selected: entry.cervixFirmness == firm,
                              onSelected: (s) {
                                setState(() {
                                  _entry = entry.copyWith(
                                      cervixFirmness: s
                                          ? firm
                                          : CervixFirmness.unset);
                                  _hasUnsavedChanges = true;
                                });
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),

            // Additional
            _buildSection(
              title: l.sectionAdditional,
              icon: Icons.more_horiz,
              children: [
                if (settings.showIntercourseTracking)
                  SwitchListTile(
                    title: Text(l.fieldIntercourse),
                    value: entry.intercourse,
                    onChanged: (v) {
                      setState(() {
                        _entry = entry.copyWith(intercourse: v);
                        _hasUnsavedChanges = true;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                SwitchListTile(
                  title: Text(l.markPeakDay),
                  subtitle: Text(l.markPeakDaySub),
                  value: entry.isPeakDay,
                  onChanged: (v) {
                    setState(() {
                      _entry = entry.copyWith(isPeakDay: v);
                      _hasUnsavedChanges = true;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),

            // Notes
            _buildSection(
              title: l.sectionNotes,
              icon: Icons.edit_note,
              children: [
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l.notesHint,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              top: BorderSide(
                  color: colors.outlineVariant.withAlpha(80)),
            ),
          ),
          child: SafeArea(
            child: FilledButton(
              onPressed: _tempError != null ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(l.saveEntry),
            ),
          ),
        ),
      ),
    );
  }

  Widget _subLabel(String text, ColorScheme colors) {
    return Text(text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: colors.onSurfaceVariant,
        ));
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    Color? iconColor,
    required List<Widget> children,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 18, color: iconColor ?? colors.primary),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  /// Normalize decimal separator: accept both comma and dot
  String _normalizeDecimal(String value) => value.replaceAll(',', '.');

  /// Validate temperature is within reasonable BBT range
  String? _validateTemperature(String value, AppSettings settings) {
    if (value.isEmpty) return null;
    final l = AppLocalizations.of(context)!;
    final normalized = _normalizeDecimal(value);
    final parsed = double.tryParse(normalized);
    if (parsed == null) return l.invalidNumber;

    if (settings.temperatureUnit == TemperatureUnit.celsius) {
      if (parsed < 35.0 || parsed > 39.0) {
        return l.rangeCelsius;
      }
    } else {
      if (parsed < 95.0 || parsed > 102.2) {
        return l.rangeFahrenheit;
      }
    }
    return null;
  }

  Future<void> _pickTime() async {
    // Default to existing time, or 6:30 AM (common BBT measurement time)
    TimeOfDay initialTime;
    if (_timeController.text.isNotEmpty) {
      final parts = _timeController.text.split(':');
      initialTime = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 6,
        minute: int.tryParse(parts.length > 1 ? parts[1] : '30') ?? 30,
      );
    } else {
      initialTime = const TimeOfDay(hour: 6, minute: 30);
    }

    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (time != null) {
      _timeController.text =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, CycleProvider provider, DayEntry entry) async {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateStr = DateFormat('MMM d', locale).format(entry.date);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteEntryTitle),
        content: Text(l.deleteEntryBody(dateStr, entry.cycleDay)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: colors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteDayEntry(entry);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.entryDeleted),
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _save() async {
    final entry = _entry;
    if (entry == null) return;

    final provider = context.read<CycleProvider>();
    final settings = provider.settings;

    // Parse temperature — empty means clear it (set to null)
    double? temperature;
    if (_tempController.text.isNotEmpty) {
      final normalized = _normalizeDecimal(_tempController.text);
      final parsed = double.tryParse(normalized);
      if (parsed != null) {
        // Validate range before saving
        final error = _validateTemperature(_tempController.text, settings);
        if (error != null) {
          setState(() => _tempError = error);
          return;
        }
        temperature = settings.storageTemp(parsed);
      }
    }

    // Use the sentinel-aware copyWith to properly handle nulls
    final reasonString = _buildReasonString();
    final updated = entry.copyWith(
      temperature: temperature, // null if cleared
      temperatureTime:
          _timeController.text.isNotEmpty ? _timeController.text : null,
      temperatureExcluded: _selectedDisturbances.isNotEmpty,
      temperatureExcludeReason: reasonString,
      notes:
          _notesController.text.isNotEmpty ? _notesController.text : null,
    );

    await provider.saveDayEntry(updated);

    if (mounted) {
      setState(() => _hasUnsavedChanges = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.entrySaved),
          duration: const Duration(seconds: 1),
        ),
      );
      Navigator.pop(context);
    }
  }

  /// Map a canonical (English, stored) disturbance factor to its localized
  /// label. Storage keeps the English value so saved reasons stay stable
  /// across language changes.
  String _disturbanceLabel(String factor, AppLocalizations l) {
    switch (factor) {
      case 'Illness':
        return l.distIllness;
      case 'Poor sleep':
        return l.distPoorSleep;
      case 'Alcohol':
        return l.distAlcohol;
      case 'Late measurement':
        return l.distLateMeasurement;
      case 'Stress':
        return l.distStress;
      case 'Travel':
        return l.distTravel;
      case 'Medication':
        return l.distMedication;
      default:
        return factor;
    }
  }

  String _mucusTypeLabel(MucusType type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case MucusType.dry:
        return l.mucusDry;
      case MucusType.nothing:
        return l.mucusNothing;
      case MucusType.moist:
        return l.mucusMoist;
      case MucusType.wet:
        return l.mucusWet;
      case MucusType.slippery:
        return l.mucusSlippery;
      case MucusType.eggWhite:
        return l.mucusEggWhite;
      case MucusType.unrecorded:
        return l.mucusNotRecorded;
    }
  }

  String _mucusAppLabel(MucusAppearance app) {
    final l = AppLocalizations.of(context)!;
    switch (app) {
      case MucusAppearance.none:
        return l.appNone;
      case MucusAppearance.cloudy:
        return l.appCloudy;
      case MucusAppearance.yellowish:
        return l.appYellowish;
      case MucusAppearance.sticky:
        return l.appSticky;
      case MucusAppearance.creamy:
        return l.appCreamy;
      case MucusAppearance.clear:
        return l.appClear;
      case MucusAppearance.stretchy:
        return l.appStretchy;
      case MucusAppearance.transparent:
        return l.appTransparent;
    }
  }

  String _bleedingLabel(BleedingType type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case BleedingType.none:
        return l.bleedNone;
      case BleedingType.spotting:
        return l.bleedSpotting;
      case BleedingType.light:
        return l.bleedLight;
      case BleedingType.medium:
        return l.bleedMedium;
      case BleedingType.heavy:
        return l.bleedHeavy;
    }
  }

  String _cervixPositionLabel(CervixPosition pos) {
    final l = AppLocalizations.of(context)!;
    switch (pos) {
      case CervixPosition.unset:
        return '';
      case CervixPosition.low:
        return l.posLow;
      case CervixPosition.medium:
        return l.posMedium;
      case CervixPosition.high:
        return l.posHigh;
    }
  }

  String _cervixOpennessLabel(CervixOpenness op) {
    final l = AppLocalizations.of(context)!;
    switch (op) {
      case CervixOpenness.unset:
        return '';
      case CervixOpenness.closed:
        return l.openClosed;
      case CervixOpenness.partiallyOpen:
        return l.openPartially;
      case CervixOpenness.open:
        return l.openOpen;
    }
  }

  String _cervixFirmnessLabel(CervixFirmness firm) {
    final l = AppLocalizations.of(context)!;
    switch (firm) {
      case CervixFirmness.unset:
        return '';
      case CervixFirmness.firm:
        return l.firmFirm;
      case CervixFirmness.medium:
        return l.firmMedium;
      case CervixFirmness.soft:
        return l.firmSoft;
    }
  }
}
