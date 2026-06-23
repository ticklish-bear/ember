import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../content/learn_content.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: l.learnTabMethod),
              Tab(text: l.learnTabFaq),
              Tab(text: l.learnTabAtlas),
            ],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _MethodTab(),
                _FaqTab(),
                _MucusAtlasTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 1: THE METHOD
// Progressive disclosure: short summaries expand into detail
// ─────────────────────────────────────────────────────────────────────────────

class _MethodTab extends StatelessWidget {
  const _MethodTab();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final topics = methodTopics(lang);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // Friendly intro
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            l.learnIntro,
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurfaceVariant,
            ),
          ),
        ),

        ...topics.map((t) => _TopicCard(
              icon: t.icon,
              title: t.title,
              summary: t.summary,
              body: t.body,
              reference: t.reference,
            )),

        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 2: FAQ — expandable Q&A
// ─────────────────────────────────────────────────────────────────────────────

class _FaqTab extends StatelessWidget {
  const _FaqTab();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            l.learnFaqIntro,
            style: TextStyle(fontSize: 14, color: colors.onSurfaceVariant),
          ),
        ),
        for (final section in faqSections(lang)) ...[
          _sectionLabel(section.label, colors),
          for (final item in section.items)
            _FaqItem(question: item.question, answer: item.answer),
        ],
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _sectionLabel(String label, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8, left: 4),
      child: Text(label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.primary,
            letterSpacing: 0.3,
          )),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 3: MUCUS ATLAS
// ─────────────────────────────────────────────────────────────────────────────

class _MucusAtlasTab extends StatelessWidget {
  const _MucusAtlasTab();

  static const _icons = [
    Icons.wb_sunny_outlined,
    Icons.remove_circle_outline,
    Icons.grain,
    Icons.water_outlined,
    Icons.opacity,
  ];
  static const _illustrations = [
    _MucusIllustration.dry,
    _MucusIllustration.nothing,
    _MucusIllustration.sticky,
    _MucusIllustration.creamy,
    _MucusIllustration.eggWhite,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final c = atlasContent(Localizations.localeOf(context).languageCode);
    final progressionColors = [
      AppColors.mucusDry,
      AppColors.mucusMoist,
      AppColors.mucusWet,
      AppColors.mucusEggWhite,
      AppColors.mucusDry,
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // How to collect a sample
        _SamplingGuide(colors: colors),
        const SizedBox(height: 20),

        // Category cards with illustrations
        for (var i = 0; i < c.categories.length; i++)
          _MucusCategoryCard(
            category: c.categories[i].category,
            quality: i,
            icon: _icons[i],
            mucusType: _illustrations[i],
            sensation: c.categories[i].sensation,
            appearance: c.categories[i].appearance,
            fingerTest: c.categories[i].fingerTest,
            fertility: c.categories[i].fertility,
            details: c.categories[i].details,
          ),

        const SizedBox(height: 16),

        // Progression
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outlineVariant.withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up,
                      size: 18, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(c.progressionTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < c.progression.length; i++)
                _ProgressionRow(c.progression[i].phase,
                    c.progression[i].mucus, progressionColors[i]),
              const SizedBox(height: 10),
              Text(
                c.progressionCaption,
                style: TextStyle(
                  fontSize: 12.5,
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Notes
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withAlpha(80),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: colors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Text(c.goodToKnowTitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurfaceVariant,
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                c.goodToKnowBody,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable widgets
// ─────────────────────────────────────────────────────────────────────────────

/// A topic card that shows a brief summary and expands on tap
class _TopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String summary;
  final String body;
  final String? reference;

  const _TopicCard({
    required this.icon,
    required this.title,
    required this.summary,
    required this.body,
    this.reference,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: ExpansionTile(
        leading: Icon(icon, size: 20, color: colors.primary),
        title: Text(title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.3,
            )),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(summary,
              style: TextStyle(
                fontSize: 12.5,
                color: colors.onSurfaceVariant,
              )),
        ),
        tilePadding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: const Border(),
        collapsedShape: const Border(),
        children: [
          const Divider(height: 1),
          const SizedBox(height: 14),
          Text(body,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.55,
                color: colors.onSurface.withAlpha(210),
              )),
          if (reference != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withAlpha(80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_book_outlined,
                      size: 13, color: colors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(reference!,
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// FAQ item — question as title, answer expands
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withAlpha(80)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Icon(Icons.help_outline,
            size: 18, color: colors.primary),
        title: Text(question,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              height: 1.3,
            )),
        children: [
          Text(answer,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colors.onSurface.withAlpha(200),
              )),
        ],
      ),
    );
  }
}

/// Mucus category card with finger-test illustration and optional photo
class _MucusCategoryCard extends StatelessWidget {
  final String category;
  final int quality;
  final IconData icon;
  final _MucusIllustration mucusType;
  final String sensation;
  final String appearance;
  final String fingerTest;
  final String fertility;
  final String details;

  const _MucusCategoryCard({
    required this.category,
    required this.quality,
    required this.icon,
    required this.mucusType,
    required this.sensation,
    required this.appearance,
    required this.fingerTest,
    required this.fertility,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final mucusColor = AppTheme.mucusColor(quality);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: mucusColor.withAlpha(25),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: mucusColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: mucusColor, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: quality >= 3
                        ? AppColors.fertile.withAlpha(25)
                        : colors.surfaceContainerHighest.withAlpha(80),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(fertility,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: quality >= 3
                            ? AppColors.fertile
                            : colors.onSurfaceVariant,
                      )),
                ),
              ],
            ),
          ),

          // Illustration
          Container(
            height: 140,
            width: double.infinity,
            color: colors.surfaceContainerLowest,
            child: CustomPaint(
              painter: _FingerTestPainter(
                mucusType: mucusType,
                mucusColor: mucusColor,
                skinColor: const Color(0xFFF0D5B8),
              ),
            ),
          ),

          // Details (expandable for long content)
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            shape: const Border(),
            collapsedShape: const Border(),
            initiallyExpanded: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                _detailRow(Icons.touch_app_outlined,
                    l.atlasSensation, sensation, colors),
                const SizedBox(height: 6),
                _detailRow(Icons.visibility_outlined,
                    l.atlasAppearance, appearance, colors),
                const SizedBox(height: 6),
                _detailRow(Icons.pinch_outlined,
                    l.atlasFingerTest, fingerTest, colors),
                const SizedBox(height: 4),
              ],
            ),
            children: [
              Text(details,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: colors.onSurface.withAlpha(190),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String text,
      ColorScheme colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: colors.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: colors.onSurface.withAlpha(200),
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Finger-test illustration painter
// ─────────────────────────────────────────────────────────────────────────────

enum _MucusIllustration {
  dry,
  nothing,
  sticky,
  creamy,
  eggWhite,
}

class _FingerTestPainter extends CustomPainter {
  final _MucusIllustration mucusType;
  final Color mucusColor;
  final Color skinColor;

  _FingerTestPainter({
    required this.mucusType,
    required this.mucusColor,
    required this.skinColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Finger spacing depends on stretch
    final double gap;
    switch (mucusType) {
      case _MucusIllustration.dry:
      case _MucusIllustration.nothing:
        gap = 20;
        break;
      case _MucusIllustration.sticky:
        gap = 28;
        break;
      case _MucusIllustration.creamy:
        gap = 40;
        break;
      case _MucusIllustration.eggWhite:
        gap = 56;
        break;
    }

    _drawFinger(canvas, cx - gap, cy, size, isLeft: true);
    _drawFinger(canvas, cx + gap, cy, size, isLeft: false);

    // Draw mucus between fingers
    switch (mucusType) {
      case _MucusIllustration.dry:
        _drawDryIndicator(canvas, cx, cy, size);
        break;
      case _MucusIllustration.nothing:
        _drawNothingIndicator(canvas, cx, cy, size);
        break;
      case _MucusIllustration.sticky:
        _drawStickyMucus(canvas, cx, cy, gap, size);
        break;
      case _MucusIllustration.creamy:
        _drawCreamyMucus(canvas, cx, cy, gap, size);
        break;
      case _MucusIllustration.eggWhite:
        _drawEggWhiteMucus(canvas, cx, cy, gap, size);
        break;
    }

    // Label under illustration
    final labelText = _labelForType(mucusType);
    final textPainter = TextPainter(
      text: TextSpan(
        text: labelText,
        style: TextStyle(
          fontSize: 11,
          color: mucusColor.withAlpha(180),
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, size.height - 22),
    );
  }

  void _drawFinger(Canvas canvas, double x, double cy, Size size,
      {required bool isLeft}) {
    final paint = Paint()..color = skinColor;
    final outline = Paint()
      ..color = skinColor.withAlpha(120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final nailPaint = Paint()
      ..color = const Color(0xFFF8E8D8);

    // Finger tip (rounded rectangle going down from center)
    final fingerWidth = 26.0;
    final fingerLength = 46.0;
    final tipRadius = fingerWidth / 2;

    final path = Path();
    if (isLeft) {
      // Left finger - tip points right
      final left = x - fingerWidth / 2;
      final top = cy - fingerLength / 2;
      path.addRRect(RRect.fromLTRBR(
        left, top,
        left + fingerWidth, top + fingerLength,
        Radius.circular(tipRadius),
      ));
    } else {
      // Right finger - tip points left
      final left = x - fingerWidth / 2;
      final top = cy - fingerLength / 2;
      path.addRRect(RRect.fromLTRBR(
        left, top,
        left + fingerWidth, top + fingerLength,
        Radius.circular(tipRadius),
      ));
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, outline);

    // Fingernail
    final nailRect = RRect.fromLTRBR(
      x - 8, cy - fingerLength / 2 + 4,
      x + 8, cy - fingerLength / 2 + 18,
      const Radius.circular(8),
    );
    canvas.drawRRect(nailRect, nailPaint);
    canvas.drawRRect(nailRect, Paint()
      ..color = skinColor.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8);

    // Finger crease lines
    final creasePaint = Paint()
      ..color = skinColor.withAlpha(80)
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(x - 8, cy + 4),
      Offset(x + 8, cy + 4),
      creasePaint,
    );
    canvas.drawLine(
      Offset(x - 6, cy + 10),
      Offset(x + 6, cy + 10),
      creasePaint,
    );
  }

  void _drawDryIndicator(Canvas canvas, double cx, double cy, Size size) {
    // Small "nothing here" indicator — dashed arc
    final paint = Paint()
      ..color = mucusColor.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 4 + (i * math.pi / 10);
      final x1 = cx + 8 * math.cos(angle);
      final y1 = cy + 8 * math.sin(angle);
      final x2 = cx + 12 * math.cos(angle);
      final y2 = cy + 12 * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  void _drawNothingIndicator(Canvas canvas, double cx, double cy,
      Size size) {
    // Very faint circle — "nothing"
    final paint = Paint()
      ..color = mucusColor.withAlpha(50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(cx, cy), 10, paint);

    // Question mark
    final textPainter = TextPainter(
      text: TextSpan(
        text: '—',
        style: TextStyle(
          fontSize: 14,
          color: mucusColor.withAlpha(80),
          fontWeight: FontWeight.w300,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas,
        Offset(cx - textPainter.width / 2, cy - textPainter.height / 2));
  }

  void _drawStickyMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    final paint = Paint()
      ..color = mucusColor.withAlpha(160)
      ..style = PaintingStyle.fill;

    // Small blobs on each fingertip, broken strand in the middle
    // Left blob
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx - gap + 14, cy),
          width: 12, height: 8),
      paint,
    );
    // Right blob
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx + gap - 14, cy),
          width: 12, height: 8),
      paint,
    );

    // Broken strand fragments
    final strandPaint = Paint()
      ..color = mucusColor.withAlpha(120)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cx - gap + 20, cy),
      Offset(cx - 6, cy - 1),
      strandPaint,
    );
    canvas.drawLine(
      Offset(cx + gap - 20, cy),
      Offset(cx + 6, cy + 1),
      strandPaint,
    );
    // Gap in middle = broken
  }

  void _drawCreamyMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    final paint = Paint()
      ..color = mucusColor.withAlpha(130);

    // Thicker strand that stretches but is opaque/creamy
    final path = Path();
    final leftEdge = cx - gap + 14;
    final rightEdge = cx + gap - 14;

    path.moveTo(leftEdge, cy - 5);
    path.cubicTo(
      cx - 10, cy - 8,
      cx + 10, cy - 3,
      rightEdge, cy - 4,
    );
    path.lineTo(rightEdge, cy + 4);
    path.cubicTo(
      cx + 10, cy + 3,
      cx - 10, cy + 8,
      leftEdge, cy + 5,
    );
    path.close();
    canvas.drawPath(path, paint);

    // Slight sheen highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withAlpha(50)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(leftEdge + 4, cy - 3),
      Offset(rightEdge - 4, cy - 2),
      highlightPaint,
    );
  }

  void _drawEggWhiteMucus(Canvas canvas, double cx, double cy,
      double gap, Size size) {
    // Long, thin, transparent stretchy strand
    final leftEdge = cx - gap + 14;
    final rightEdge = cx + gap - 14;

    // Main strand — slight sag
    final path = Path();
    path.moveTo(leftEdge, cy);
    path.quadraticBezierTo(cx, cy + 10, rightEdge, cy);
    canvas.drawPath(path, Paint()
      ..color = mucusColor.withAlpha(60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round);

    // Thinner parallel strand
    final path2 = Path();
    path2.moveTo(leftEdge, cy - 2);
    path2.quadraticBezierTo(cx, cy + 6, rightEdge, cy - 2);
    canvas.drawPath(path2, Paint()
      ..color = mucusColor.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);

    // Sheen highlights
    canvas.drawLine(
      Offset(cx - 20, cy + 3),
      Offset(cx + 15, cy + 5),
      Paint()
        ..color = Colors.white.withAlpha(70)
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round,
    );

    // Blobs on fingertips
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(leftEdge, cy),
          width: 10, height: 10),
      Paint()..color = mucusColor.withAlpha(70),
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(rightEdge, cy),
          width: 10, height: 10),
      Paint()..color = mucusColor.withAlpha(70),
    );

    // Stretch distance label
    final distPainter = TextPainter(
      text: TextSpan(
        text: '↔ 3–10+ cm',
        style: TextStyle(
          fontSize: 10,
          color: mucusColor.withAlpha(140),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    distPainter.paint(canvas,
        Offset(cx - distPainter.width / 2, cy + 16));
  }

  String _labelForType(_MucusIllustration type) {
    switch (type) {
      case _MucusIllustration.dry:
        return 'No mucus between fingers';
      case _MucusIllustration.nothing:
        return 'Nothing to pick up';
      case _MucusIllustration.sticky:
        return 'Breaks apart immediately';
      case _MucusIllustration.creamy:
        return 'Stretches 1–2 cm, creamy';
      case _MucusIllustration.eggWhite:
        return 'Long elastic threads';
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Guide on how to collect a mucus sample
class _SamplingGuide extends StatelessWidget {
  final ColorScheme colors;

  const _SamplingGuide({required this.colors});

  @override
  Widget build(BuildContext context) {
    final c = atlasContent(Localizations.localeOf(context).languageCode);
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: const Border(),
        collapsedShape: const Border(),
        initiallyExpanded: true,
        leading: Icon(Icons.lightbulb_outline,
            size: 20, color: colors.primary),
        title: Text(c.samplingTitle,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: colors.primary,
            )),
        children: [
          Text(
            c.samplingIntro,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: colors.onSurface.withAlpha(200),
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < c.samplingMethods.length; i++)
            _samplingMethod('${i + 1}', c.samplingMethods[i].title,
                c.samplingMethods[i].text),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.tertiaryContainer.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates_outlined,
                    size: 16, color: colors.tertiary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    c.samplingTip,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: colors.onSurface.withAlpha(190),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _samplingMethod(String number, String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Text(number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    )),
                const SizedBox(height: 3),
                Text(text,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: colors.onSurface.withAlpha(190),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressionRow extends StatelessWidget {
  final String phase;
  final String mucus;
  final Color color;

  const _ProgressionRow(this.phase, this.mucus, this.color);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(phase,
                style: TextStyle(
                  fontSize: 12.5,
                  color: colors.onSurface,
                )),
          ),
          Expanded(
            child: Text(mucus,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant,
                )),
          ),
        ],
      ),
    );
  }
}
