import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/support_links.dart';
import '../l10n/app_localizations.dart';

/// A quiet, non-pushy "support development" screen.
///
/// The tone is deliberately low-key: the app is free, this changes nothing,
/// and nobody is pressured. Donations grant no in-app benefit.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _openKofi(BuildContext context) async {
    final uri = Uri.parse(SupportLinks.kofi);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.supportLinkError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l.supportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(Icons.local_cafe_outlined,
                  color: colors.onPrimaryContainer, size: 30),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l.supportHeadline,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Text(
            l.supportBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () => _openKofi(context),
            icon: const Icon(Icons.local_cafe_outlined),
            label: Text(l.supportButton),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l.supportFootnote,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
