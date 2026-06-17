import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// Универсальная обёртка для секции
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final EdgeInsets? padding;

  const SectionWrapper({
    super.key,
    required this.child,
    this.bgColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? AppColors.bg,
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: AppSpacing.sectionV,
            horizontal: AppSpacing.contentH,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// Метка секции - «О себе», «Навыки» и т.д.
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
        color: AppColors.accent,
      ),
    );
  }
}

/// Заголовок секции
class SectionTitle extends StatelessWidget {
  final String text;
  final TextAlign align;
  const SectionTitle(this.text, {super.key, this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.25,
        letterSpacing: -0.3,
      ),
    );
  }
}

/// Тег / чип
class TagChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;

  const TagChip({
    super.key,
    required this.label,
    this.color = AppColors.tagText,
    this.bgColor = AppColors.tagBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

/// Карточка с мягкой тенью
class SoftCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;

  const SoftCard({super.key, required this.child, this.padding, this.color});

  @override
  State<SoftCard> createState() => _SoftCardState();
}

class _SoftCardState extends State<SoftCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: widget.padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.borderHover : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.08 : 0.04),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
