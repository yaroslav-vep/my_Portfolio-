import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class MetricsSection extends StatefulWidget {
  const MetricsSection({super.key});

  @override
  State<MetricsSection> createState() => _MetricsSectionState();
}

class _MetricsSectionState extends State<MetricsSection> {
  int _selectedTab = 0;

  static const _tabs = ['Монетизация', 'Вовлечённость', 'Удержание'];

  static const _metrics = [
    // Монетизация
    [
        _MetricData('ARPU', 'Average Revenue Per User',
          'Средняя выручка на одного пользователя. Используется, чтобы понять общий уровень монетизации продукта - насколько хорошо он генерирует деньги со всей базы, включая тех, кто не платит.',
          'ARPU = Revenue / Total Users'),
        _MetricData('ARPPU', 'Average Revenue Per Paying User',
          'Выручка только с платящих. Помогает понять реальную ценность для того, кто уже решил платить. Обычно в 3–5 раз выше ARPU - разница показывает, какая доля базы монетизируется.',
          'ARPPU = Revenue / Paying Users'),
        _MetricData('LTV', 'Lifetime Value',
          'Сколько денег пользователь принесёт за всё время в продукте. Это одна из ключевых метрик для оценки юнит-экономики - рентабельно ли привлекать пользователей по текущим ценам.',
          'LTV ≈ ARPU × Avg Lifetime'),
        _MetricData('CAC', 'Customer Acquisition Cost',
          'Стоимость привлечения одного клиента. Сравниваю с LTV: если LTV/CAC < 1 - бизнес убыточен по привлечению. Норма - 3 и выше.',
          'CAC = Marketing Spend / New Customers'),
    ],
    // Вовлечённость
    [
        _MetricData('DAU', 'Daily Active Users',
          'Уникальные пользователи, которые сделали целевое действие за день. Важно понимать, что именно считается "активным" - это зависит от продукта.',
          'DAU = Unique active users / day'),
        _MetricData('MAU', 'Monthly Active Users',
          'Аналогично DAU, но за месяц. Показывает масштаб аудитории. Быстрый рост MAU при падающем DAU - тревожный знак.',
          'MAU = Unique active users / 30 days'),
        _MetricData('DAU/MAU', 'Stickiness',
          'Насколько "прилипчив" продукт - как часто пользователи возвращаются. 20%+ считается нормальным, у мессенджеров бывает 50–70%.',
          'Stickiness = DAU / MAU × 100%'),
    ],
    // Удержание
    [
        _MetricData('Retention', 'User Retention',
          'Процент пользователей, вернувшихся через N дней после первого визита. D1, D7, D30 - классические отсечки. Падение на D1 часто говорит о проблемах в онбординге.',
          'Retention D7 = Returned on D7 / Cohort × 100%'),
        _MetricData('Cohort', 'Cohort Analysis',
          'Сравниваю группы пользователей, привлечённых в разные периоды. Если одна когорта явно хуже - значит, в этот период что-то изменилось в продукте или маркетинге.',
          'Cohort = Группа по дате привлечения'),
      _MetricData('Churn', 'Churn Rate',
          'Доля пользователей, которые перестали пользоваться продуктом. Обратная сторона Retention. Высокий Churn + рост MAU = "дырявое ведро".',
          'Churn = Lost Users / Start Users × 100%'),
      _MetricData('C1', 'Конверсия первого шага',
          'Конверсия на первом, самом критичном шаге воронки. Чаще всего это регистрация или первое целевое действие. Небольшой рост C1 даёт непропорционально большой эффект на весь продукт.',
          'C1 = Step 1 Completions / Visitors × 100%'),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      bgColor: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(child: const SectionLabel('Метрики')),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 80),
            child: const SectionTitle('Продуктовые метрики'),
          ),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 120),
            child: Text(
              'Понимаю, когда и зачем каждую метрику смотреть.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: const Duration(milliseconds: 160),
            child: _buildTabs(),
          ),
          const SizedBox(height: 24),
          _buildMetricCards(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _tabs.asMap().entries.map((e) {
        final active = e.key == _selectedTab;
        return GestureDetector(
          onTap: () => setState(() => _selectedTab = e.key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: active ? AppColors.accent : AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: active ? AppColors.accent : AppColors.border,
              ),
            ),
            child: Text(
              e.value,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMetricCards() {
    final metrics = _metrics[_selectedTab];
    final isWide = MediaQuery.of(context).size.width > 700;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: KeyedSubtree(
        key: ValueKey(_selectedTab),
        child: isWide
            ? Wrap(
                spacing: 16,
                runSpacing: 16,
                children: metrics.map((m) {
                  return SizedBox(
                    width: 510,
                    child: _MetricCard(data: m),
                  );
                }).toList(),
              )
            : Column(
                children: metrics.map((m) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _MetricCard(data: m),
                  );
                }).toList(),
              ),
      ),
    );
  }
}

class _MetricData {
  final String badge;
  final String title;
  final String desc;
  final String formula;

  const _MetricData(this.badge, this.title, this.desc, this.formula);
}

class _MetricCard extends StatefulWidget {
  final _MetricData data;
  const _MetricCard({super.key, required this.data});

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered ? AppColors.borderHover : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.07 : 0.03),
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    d.badge,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    d.title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              d.desc,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                d.formula,
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  color: AppColors.accentText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
