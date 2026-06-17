import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      color: AppColors.surface,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 120,
        bottom: AppSpacing.sectionV,
        left: AppSpacing.contentH,
        right: AppSpacing.contentH,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxWidth),
          child: isWide
              ? _buildWide(context)
              : _buildNarrow(context),
        ),
      ),
    );
  }

  Widget _buildWide(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _buildText()),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildCard()),
      ],
    );
  }

  Widget _buildNarrow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        const SizedBox(height: 40),
        _buildCard(),
      ],
    );
  }

  Widget _buildText() {
    return FadeIn(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Поступление в бакалавриат IT-университета',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Продуктовый\аналитик',
            style: GoogleFonts.inter(
              fontSize: 46,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.15,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Меня зовут Ярослав. Я окончил Compass College по направлению '
            'продуктовой аналитики. В учебе работал с реальными данными: '
            'строил воронки, считал метрики удержания, разбирался в юнит-экономике. '
            'Хочу продолжить развитие в бакалавриате.',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              TagChip(label: 'SQL',       color: AppColors.sqlColor,    bgColor: AppColors.sqlBg),
              TagChip(label: 'Python',    color: AppColors.pythonColor, bgColor: AppColors.pythonBg),
              TagChip(label: 'Amplitude', color: AppColors.ampColor,    bgColor: AppColors.ampBg),
              TagChip(label: 'Продуктовые метрики'),
              TagChip(label: 'A/B тесты'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return FadeIn(
      delay: const Duration(milliseconds: 250),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Коротко о себе',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            _StatRow(icon: Icons.school_outlined,      label: 'Compass College',           sub: 'IT & Продуктовая аналитика'),
            const SizedBox(height: 16),
            _StatRow(icon: Icons.bar_chart_outlined,   label: '15+ учебных проектов',      sub: 'Реальные датасеты'),
            const SizedBox(height: 16),
            _StatRow(icon: Icons.psychology_outlined,  label: 'ARPU · LTV · Retention',   sub: 'Ключевые метрики'),
            const SizedBox(height: 16),
            _StatRow(icon: Icons.location_on_outlined, label: 'Кыргызстан',                 sub: 'Текущая локация'),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  const _StatRow({required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: AppColors.accent),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
