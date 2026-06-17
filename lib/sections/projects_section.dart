import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const _projects = [
    _ProjectData(
      emoji: '📊',
      title: 'Когортный Retention-анализ',
      context: 'Учебный кейс · Compass College',
      desc: 'Брал реальный датасет мобильного приложения и смотрел, '
            'как ведут себя когорты пользователей во времени. Нашёл, что '
            'когорты февраля держат D7-Retention на 8% ниже остальных. '
            'Начал разбираться - оказалось, в тот период поменяли онбординг. '
            'Предложил гипотезу для A/B теста.',
      what: 'Что сделал: когортная таблица в SQL + тепловая карта в Python',
      tools: ['PostgreSQL', 'pandas', 'seaborn', 'Amplitude'],
      highlight: '-8% Retention D7 в когортах февраля -> гипотеза про онбординг',
      isFeatured: true,
      imageUrl: 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&w=800&q=80',
      externalLink: 'https://app.amplitude.com/analytics/demo/notebook/ktbnqci9?source=copy+url',
    ),
    _ProjectData(
      emoji: '🔽',
      title: 'Воронка конверсии Complete_purchase',
      context: 'Аналитический отчёт · Электронная коммерция',
      desc: 'Построил воронку от регистрации до первой покупки Complete_purchase. '
            'Обнаружил, что основная часть пользователей уходит на промежуточных шагах оформления. '
            'Сравнил с бенчмарками и предложил шаги по оптимизации конверсии.',
      what: 'Что сделал: воронка в Amplitude + отчёт в Amplitude Notebook',
      tools: ['Amplitude', 'Funnels', 'User Paths'],
      highlight: 'Анализ конверсии покупки на демо-данных',
      isFeatured: false,
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=800&q=80',
      externalLink: 'https://app.amplitude.com/analytics/demo/notebook/ktbnqci9?source=copy+url',
    ),
    _ProjectData(
      emoji: '🏢',
      title: 'B2B SaaS Analytics - Регистрация',
      context: 'Аналитический отчёт · Amplitude Demo',
      desc: 'Анализ критических событий при онбординге B2B SaaS продукта. '
            'Исследовал шаги регистрации нового пользователя и на каком '
            'этапе процесса активации происходит наибольший отток аудитории.',
      what: 'Что сделал: исследование активации пользователя в Amplitude',
      tools: ['Amplitude', 'SaaS Metrics', 'User Journeys'],
      highlight: 'Анализ критических событий активации',
      isFeatured: false,
      imageUrl: 'https://images.unsplash.com/photo-1543286386-7a393e921bc2?auto=format&fit=crop&w=800&q=80',
      externalLink: 'https://app.amplitude.com/analytics/demo/notebook/sxbndscj?source=copy+url',
    ),
    _ProjectData(
      emoji: '🧪',
      title: 'Дизайн A/B теста',
      context: 'Самостоятельный проект',
      desc: 'Разработал полный дизайн A/B теста для нового онбординга: '
      'рассчитал размер выборки, выбрал метрики успеха (C1 и D7 Retention), '
      'описал критерии остановки. Разобрался, почему важен p < 0.05 '
      'и что такое ошибка первого рода на практике.',
      what: 'Что сделал: расчёт выборки в Python + описание методологии',
      tools: ['Python', 'scipy', 'Google Sheets'],
      highlight: 'p < 0.05 · Мощность 80% · N = 1 240 на группу',
      isFeatured: false,
      imageUrl: 'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?auto=format&fit=crop&w=800&q=80',
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
          FadeIn(child: const SectionLabel('Проекты')),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 80),
            child: const SectionTitle('Учебные кейсы'),
          ),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 120),
            child: Text(
              'Всё это делал в рамках обучения или самостоятельно. '
              'Реальных коммерческих проектов пока мало',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 40),
          _buildProjects(isWide),
        ],
      ),
    );
  }

  Widget _buildProjects(bool isWide) {
    if (!isWide) {
      return Column(
        children: _projects.asMap().entries.map((e) {
          return Padding(
            padding: EdgeInsets.only(bottom: e.key < _projects.length - 1 ? 16 : 0),
            child: FadeIn(
              delay: Duration(milliseconds: 80 * e.key),
              child: _ProjectCard(data: e.value),
            ),
          );
        }).toList(),
      );
    }

    // Wide: featured card spans full width, rest in 2 columns
    final featured  = _projects.where((p) => p.isFeatured).toList();
    final secondary = _projects.where((p) => !p.isFeatured).toList();

    return Column(
      children: [
        ...featured.map((p) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FadeIn(child: _ProjectCard(data: p, fullWidth: true)),
        )),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: secondary.asMap().entries.map((e) {
            return SizedBox(
              width: 526,
              child: FadeIn(
                delay: Duration(milliseconds: 80 * e.key),
                child: _ProjectCard(data: e.value),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ProjectData {
  final String emoji;
  final String title;
  final String context;
  final String desc;
  final String what;
  final List<String> tools;
  final String highlight;
  final bool isFeatured;
  final String? imageUrl;
  final String? externalLink;

  const _ProjectData({
    required this.emoji,
    required this.title,
    required this.context,
    required this.desc,
    required this.what,
    required this.tools,
    required this.highlight,
    required this.isFeatured,
    this.imageUrl,
    this.externalLink,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;
  final bool fullWidth;
  const _ProjectCard({super.key, required this.data, this.fullWidth = false});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: d.externalLink != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: d.externalLink == null ? null : () async {
          final uri = Uri.parse(d.externalLink!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? AppColors.borderHover : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hovered ? 0.08 : 0.03),
                blurRadius: _hovered ? 18 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (d.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  d.imageUrl!,
                  height: widget.fullWidth ? 200 : 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const SizedBox.shrink(),
                ),
              ),
            // Top section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (d.isFeatured)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3E2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Ключевой проект',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ampColor,
                          ),
                        ),
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.emoji, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d.title,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              d.context,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
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
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    d.what,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom section
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      d.highlight,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: d.tools.map((t) => TagChip(label: t)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
