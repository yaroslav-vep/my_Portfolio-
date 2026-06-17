import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    _SkillData(
      icon: Icons.storage_outlined,
      title: 'SQL',
      level: 'Хорошо',
      levelColor: AppColors.sqlColor,
      levelBg: AppColors.sqlBg,
      desc: 'Пишу запросы с JOIN, подзапросами, оконными функциями. '
            'Работал с PostgreSQL и ClickHouse в учебных проектах. '
            'Могу достать нужный срез данных из сложной схемы.',
      tags: ['SELECT · JOIN', 'Window Functions', 'CTEs', 'GROUP BY'],
      progress: 0.82,
    ),
    _SkillData(
      icon: Icons.code_outlined,
      title: 'Python',
      level: 'Средне',
      levelColor: AppColors.pythonColor,
      levelBg: AppColors.pythonBg,
      desc: 'Использую для анализа данных и визуализации. pandas для '
            'обработки таблиц, matplotlib и seaborn для графиков. '
            'Работаю в Jupyter Notebook.',
      tags: ['pandas', 'matplotlib', 'seaborn', 'Jupyter'],
      progress: 0.68,
    ),
    _SkillData(
      icon: Icons.show_chart_outlined,
      title: 'Amplitude',
      level: 'Средне',
      levelColor: AppColors.ampColor,
      levelBg: AppColors.ampBg,
      desc: 'Строю воронки конверсии, когортный анализ, Retention-чарты. '
            'Умею настроить дашборд для продакт-менеджера и объяснить, '
            'что на нём происходит.',
      tags: ['Funnels', 'Cohort Analysis', 'Retention', 'User Paths'],
      progress: 0.72,
    ),
    _SkillData(
      icon: Icons.table_chart_outlined,
      title: 'Excel / Google Sheets',
      level: 'Хорошо',
      levelColor: AppColors.sqlColor,
      levelBg: AppColors.sqlBg,
      desc: 'Сводные таблицы, формулы, простые модели. Это был первый '
            'инструмент для анализа, и в нём я чувствую себя уверенно '
            'для быстрых расчётов.',
      tags: ['Pivot Tables', 'VLOOKUP', 'Charts', 'Unit Economics'],
      progress: 0.88,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return SectionWrapper(
      bgColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(child: const SectionLabel('Инструменты')),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 80),
            child: const SectionTitle('Что умею и на каком уровне'),
          ),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 120),
            child: Text(
              'Стараюсь быть честным: ниже написал реальный уровень, '
              'а не "продвинутый" везде.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 40),
          isWide
              ? _buildGrid()
              : _buildList(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: _skills.asMap().entries.map((e) {
        return SizedBox(
          width: 510,
          child: FadeIn(
            delay: Duration(milliseconds: 80 * e.key),
            child: _SkillCard(data: e.value),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildList() {
    return Column(
      children: _skills.asMap().entries.map((e) {
        return Padding(
          padding: EdgeInsets.only(bottom: e.key < _skills.length - 1 ? 16 : 0),
          child: FadeIn(
            delay: Duration(milliseconds: 80 * e.key),
            child: _SkillCard(data: e.value),
          ),
        );
      }).toList(),
    );
  }
}

class _SkillData {
  final IconData icon;
  final String title;
  final String level;
  final Color levelColor;
  final Color levelBg;
  final String desc;
  final List<String> tags;
  final double progress;

  const _SkillData({
    required this.icon,
    required this.title,
    required this.level,
    required this.levelColor,
    required this.levelBg,
    required this.desc,
    required this.tags,
    required this.progress,
  });
}

class _SkillCard extends StatefulWidget {
  final _SkillData data;
  const _SkillCard({required this.data});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _barCtrl;
  late Animation<double> _barAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _barCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _barAnim = Tween(begin: 0.0, end: widget.data.progress).animate(
      CurvedAnimation(parent: _barCtrl, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _barCtrl.forward();
    });
  }

  @override
  void dispose() {
    _barCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.borderHover : AppColors.border,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 18, offset: const Offset(0, 4))]
              : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(d.icon, size: 20, color: AppColors.accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    d.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: d.levelBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    d.level,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: d.levelColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              d.desc,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: d.tags.map((t) => TagChip(label: t)).toList(),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => LinearProgressIndicator(
                  value: _barAnim.value,
                  minHeight: 4,
                  backgroundColor: AppColors.surfaceAlt,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
