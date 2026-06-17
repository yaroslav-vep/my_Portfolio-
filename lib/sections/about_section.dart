import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return SectionWrapper(
      bgColor: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(child: const SectionLabel('О себе')),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 80),
            child: const SectionTitle('Почему продуктовая аналитика'),
          ),
          const SizedBox(height: 40),
          isWide ? _buildWide() : _buildNarrow(),
        ],
      ),
    );
  }

  Widget _buildWide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildStory()),
        const SizedBox(width: 48),
        SizedBox(
          width: 340,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=700&q=80',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: AppColors.accentLight,
                    child: const Icon(Icons.analytics_outlined, size: 48, color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildValues(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrow() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=700&q=80',
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 24),
        _buildStory(),
        const SizedBox(height: 32),
        _buildValues(),
      ],
    );
  }

  Widget _buildStory() {
    return FadeIn(
      delay: const Duration(milliseconds: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Я выбрал это направление не случайно. Мне всегда было интереснее '
            'понять, почему люди делают те или иные выборы в продукте, '
            'чем просто смотреть на цифры. Продуктовая аналитика - это '
            'именно тот стык, где данные объясняют поведение, а не просто его фиксируют.',
            style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary, height: 1.8),
          ),
          const SizedBox(height: 16),
          Text(
            'В Compass College я прошёл курс, где большую часть времени работал '
            'с реальными датасетами. Строил когортный анализ, считал юнит-экономику, '
            'разбирал, как одно изменение в онбординге влияет на недельный Retention. '
            'Это дало понимание, что аналитик - это не тот, кто делает красивые '
            'графики, а тот, кто задаёт правильные вопросы к данным.',
            style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary, height: 1.8),
          ),
          const SizedBox(height: 16),
          Text(
            'При поступлении в вуз на бакалавриат я хочу углубиться в статистику, поработать с более '
            'сложными моделями и научиться строить аналитику с нуля в условиях '
            'реального продукта, а не учебного кейса.',
            style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary, height: 1.8),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderHover.withOpacity(0.6)),
            ),
            child: Row(
              children: [
                const Icon(Icons.format_quote, color: AppColors.accent, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Хороший аналитик не тот, кто знает всё про SQL, а тот, кто умеет '
                    'задать правильный вопрос к данным.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.accentText,
                      fontStyle: FontStyle.italic,
                      height: 1.6,
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

  Widget _buildValues() {
    final items = [
      (Icons.search_outlined,         'Умею задавать вопросы к данным',        'Не просто считаю - думаю, что именно нужно проверить'),
      (Icons.people_outline,          'Понимаю продукт с точки зрения пользователя', 'Метрики - это про людей, а не про числа'),
      (Icons.layers_outlined,         'Знаю стек под задачу',                  'SQL для запросов, Python для анализа, Amplitude для поведения'),
    ];
    return Column(
      children: items.asMap().entries.map((e) {
        return Padding(
          padding: EdgeInsets.only(bottom: e.key < items.length - 1 ? 16 : 0),
          child: FadeIn(
            delay: Duration(milliseconds: 200 + e.key * 80),
            child: SoftCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(e.value.$1, size: 18, color: AppColors.accent),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.$2,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e.value.$3,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
