import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/metrics_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'widgets/nav_bar.dart';
import 'theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Портфолио - Продуктовый аналитик',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final _heroKey      = GlobalKey();
  final _aboutKey     = GlobalKey();
  final _skillsKey    = GlobalKey();
  final _metricsKey   = GlobalKey();
  final _projectsKey  = GlobalKey();
  final _contactKey   = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(key: _heroKey, child: const HeroSection()),
                SizedBox(key: _aboutKey, child: const AboutSection()),
                SizedBox(key: _skillsKey, child: const SkillsSection()),
                SizedBox(key: _metricsKey, child: const MetricsSection()),
                SizedBox(key: _projectsKey, child: const ProjectsSection()),
                SizedBox(key: _contactKey, child: const ContactSection()),
                _buildFooter(),
              ],
            ),
          ),
          NavBar(
            onHero:     () => _scrollTo(_heroKey),
            onAbout:    () => _scrollTo(_aboutKey),
            onSkills:   () => _scrollTo(_skillsKey),
            onMetrics:  () => _scrollTo(_metricsKey),
            onProjects: () => _scrollTo(_projectsKey),
            onContact:  () => _scrollTo(_contactKey),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      child: Text(
        '© 2024 · Выпускник Compass College · IT & Product Design',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
