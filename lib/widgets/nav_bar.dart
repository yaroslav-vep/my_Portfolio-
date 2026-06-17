import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class NavBar extends StatefulWidget {
  final VoidCallback onHero;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onMetrics;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.onHero,
    required this.onAbout,
    required this.onSkills,
    required this.onMetrics,
    required this.onProjects,
    required this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels > 20 && !_scrolled) {
            setState(() => _scrolled = true);
          } else if (notification.metrics.pixels <= 20 && _scrolled) {
            setState(() => _scrolled = false);
          }
          return false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: _scrolled
                ? AppColors.surface.withOpacity(0.95)
                : Colors.transparent,
            border: _scrolled
                ? Border(
                    bottom: BorderSide(color: AppColors.border, width: 1),
                  )
                : null,
            boxShadow: _scrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 20,
            vertical: 16,
          ),
          child: isWide
              ? _buildDesktopNav()
              : _buildMobileNav(context),
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onHero,
          child: Text(
            'Портфолио',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const Spacer(),
        _NavLink('О себе',  widget.onAbout),
        const SizedBox(width: 28),
        _NavLink('Навыки',  widget.onSkills),
        const SizedBox(width: 28),
        _NavLink('Метрики', widget.onMetrics),
        const SizedBox(width: 28),
        _NavLink('Проекты', widget.onProjects),
        const SizedBox(width: 28),
        _NavLink('Контакты', widget.onContact),
        const SizedBox(width: 32),
        _ContactButton(onTap: widget.onContact),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return Row(
      children: [
        Text(
          'Портфолио',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textSecondary),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => _MobileMenu(
                onAbout:    widget.onAbout,
                onSkills:   widget.onSkills,
                onMetrics:  widget.onMetrics,
                onProjects: widget.onProjects,
                onContact:  widget.onContact,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _hovered ? AppColors.accent : AppColors.textSecondary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ContactButton({required this.onTap});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentText : AppColors.accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Написать',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onAbout, onSkills, onMetrics, onProjects, onContact;

  const _MobileMenu({
    required this.onAbout,
    required this.onSkills,
    required this.onMetrics,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('О себе',    onAbout),
      ('Навыки',    onSkills),
      ('Метрики',   onMetrics),
      ('Проекты',   onProjects),
      ('Контакты',  onContact),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            return ListTile(
              title: Text(
                item.$1,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                item.$2();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
