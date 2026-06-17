import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      bgColor: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(child: const SectionLabel('Контакты')),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 80),
            child: const SectionTitle('Как со мной связаться'),
          ),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 120),
            child: Text(
              'Если вам интересно поговорить - пишите. '
              'Отвечаю обычно в течение дня.',
              style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary, height: 1.7),
            ),
          ),
          const SizedBox(height: 40),
          FadeIn(
            delay: const Duration(milliseconds: 160),
            child: _buildCards(),
          ),
          const SizedBox(height: 48),
          FadeIn(
            delay: const Duration(milliseconds: 200),
            child: _buildMotivation(),
          ),
        ],
      ),
    );
  }

  Widget _buildCards() {
    final contacts = [
      _ContactItem(
        icon: Icons.email_outlined,
        label: 'Email',
        value: 'your.email@example.com',
        url: 'mailto:your.email@example.com',
      ),
      _ContactItem(
        icon: Icons.telegram,
        label: 'Telegram',
        value: '@yourusername',
        url: 'https://t.me/yourusername',
      ),
      _ContactItem(
        icon: Icons.link,
        label: 'LinkedIn',
        value: 'linkedin.com/in/yourprofile',
        url: 'https://linkedin.com/in/yourprofile',
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: contacts.map((c) => _ContactCard(item: c)).toList(),
    );
  }

  Widget _buildMotivation() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.school_outlined, size: 20, color: AppColors.accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Почему именно бакалавриат',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'На курсе я понял, что мне интересно не просто применять метрики, '
                  'а понимать, как они устроены изнутри. Хочу получить сильную базу в '
                  'статистике, в экспериментах, научиться работать с данными на уровне, '
                  'который даёт академическая программа бакалавриата. Вижу себя через 5 лет '
                  'в роли сильного аналитика в продуктовой команде.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.75,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;
  final String url;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });
}

class _ContactCard extends StatefulWidget {
  final _ContactItem item;
  const _ContactCard({super.key, required this.item});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.item;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(c.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          width: 300,
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
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(c.icon, size: 18, color: AppColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.label,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      c.value,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _hovered ? AppColors.accent : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 14,
                color: _hovered ? AppColors.accent : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
