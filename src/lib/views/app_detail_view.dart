import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_model.dart';
import '../widgets/programmatic_background.dart';
import '../widgets/nav_bar.dart';

class AppDetailView extends StatefulWidget {
  final AppModel app;
  final Function(String) onNavigate;

  const AppDetailView({
    super.key,
    required this.app,
    required this.onNavigate,
  });

  @override
  State<AppDetailView> createState() => _AppDetailViewState();
}

class _AppDetailViewState extends State<AppDetailView> {
  final ScrollController _screenshotController = ScrollController();

  Future<void> _launchUrl(String urlString, {bool sameTab = false}) async {
    final Uri url = Uri.parse(urlString);
    if (sameTab) {
      if (!await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_self',
      )) {
        throw Exception('Could not launch $url');
      }
    } else {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  void dispose() {
    _screenshotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      body: ProgrammaticBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Unified Floating Navbar
              NavBar(
                onNavigate: widget.onNavigate,
                currentRoute: '/${widget.app.id}.html',
              ),

              // Main Article Container
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0,
                  vertical: 24.0,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Hero header
                        _buildHeroHeader(isMobile),

                        const SizedBox(height: 48),

                        // Problem / About Section
                        if (widget.app.problemTitle != null && widget.app.problemContent != null)
                          _buildProblemSection(isMobile),

                        // Subpage Resources Section (e.g. Chess Academy Showcase/Manual)
                        if (widget.app.subPageLinks.isNotEmpty) ...[
                          const SizedBox(height: 48),
                          _buildSubPageLinks(isMobile),
                        ],

                        // Coming soon badge if applicable
                        if (widget.app.isComingSoon) ...[
                          const SizedBox(height: 48),
                          _buildComingSoonSection(),
                        ],

                        // Main sections for Live Apps
                        if (!widget.app.isComingSoon) ...[
                          const SizedBox(height: 64),

                          // Screenshots Gallery
                          if (widget.app.screenshots.isNotEmpty) ...[
                            _buildScreenshotsSection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // Features Section
                          if (widget.app.features.isNotEmpty) ...[
                            _buildFeaturesSection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // How It Works Section
                          if (widget.app.howItWorks != null) ...[
                            _buildHowItWorksSection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // Theme Showcase (for Nu)
                          if (widget.app.themePills.isNotEmpty) ...[
                            _buildThemeShowcaseSection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // Glossary Section (for Flux)
                          if (widget.app.glossary.isNotEmpty) ...[
                            _buildGlossarySection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // Guidelines Section
                          if (widget.app.guidelines.isNotEmpty) ...[
                            _buildGuidelinesSection(isMobile),
                            const SizedBox(height: 64),
                          ],

                          // CTA / Get it today
                          _buildCTASection(isMobile),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 80),

              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildHeroHeader(bool isMobile) {
    return Column(
      children: [
        // App Icon
        if (widget.app.logoPath != null)
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                widget.app.logoPath!,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          )
        else
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.app.placeholderChar ?? widget.app.name[0],
              style: GoogleFonts.outfit(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: widget.app.placeholderColor,
              ),
            ),
          ),

        const SizedBox(height: 24),

        // App Name
        Text(
          widget.app.name,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 32 : 44,
            fontWeight: FontWeight.w600,
            color: const Color(0xff0f172a),
          ),
        ),

        const SizedBox(height: 8),

        // Tagline
        Text(
          widget.app.taglineLong ?? widget.app.tagline,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 14 : 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xff475569),
            letterSpacing: 1,
          ),
        ),

        // Hero Graphic Banner
        if (widget.app.heroImage != null) ...[
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                widget.app.heroImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProblemSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.app.problemTitle!,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xff0f172a),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.app.problemContent!,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: const Color(0xff475569),
              height: 1.8,
            ),
          ),
          if (widget.app.problemContent2 != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.app.problemContent2!,
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: const Color(0xff475569),
                height: 1.8,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubPageLinks(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore ${widget.app.name} Resources',
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xff0f172a),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Access interactive web previews, operating instructions, and simulation dashboards compiled specifically for the web.',
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: const Color(0xff475569),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: widget.app.subPageLinks.map((link) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    final route = link.url.startsWith('/') ? link.url : '/${link.url}';
                    widget.onNavigate(route);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: widget.app.accentColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.app.accentColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.app.accentColor.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          link.icon,
                          color: widget.app.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          link.title,
                          style: GoogleFonts.outfit(
                            color: const Color(0xff0f172a),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: const Color(0xff475569),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonSection() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        ),
        child: Text(
          'COMING SOON',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.app.placeholderColor,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A Visual Journey',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w600,
            color: const Color(0xff0f172a),
          ),
        ),
        const SizedBox(height: 32),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 320,
              child: ListView.builder(
                controller: _screenshotController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.app.screenshots.length,
                itemBuilder: (context, index) {
                  final imgPath = widget.app.screenshots[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imgPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Floating arrows for easy scrolling on desktop
            if (!isMobile) ...[
              Positioned(
                left: 8,
                child: _buildScrollChevron(
                  icon: Icons.chevron_left_rounded,
                  onPressed: () {
                    if (_screenshotController.hasClients) {
                      final target = (_screenshotController.offset - 360)
                          .clamp(0.0, _screenshotController.position.maxScrollExtent);
                      _screenshotController.animateTo(
                        target,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
              Positioned(
                right: 8,
                child: _buildScrollChevron(
                  icon: Icons.chevron_right_rounded,
                  onPressed: () {
                    if (_screenshotController.hasClients) {
                      final target = (_screenshotController.offset + 360)
                          .clamp(0.0, _screenshotController.position.maxScrollExtent);
                      _screenshotController.animateTo(
                        target,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildScrollChevron({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onPressed,
          hoverColor: Colors.black.withValues(alpha: 0.04),
          child: Icon(
            icon,
            color: const Color(0xff0f172a),
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gradient Title
          ShaderMask(
            shaderCallback: (bounds) => widget.app.accentGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              widget.app.id == 'nu' ? '🌍 Global Script Support' : '✨ Key Features',
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 24 : 30,
                fontWeight: FontWeight.w600,
                color: Colors.white, // needed for ShaderMask to show correctly
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.app.id == 'nu'
                ? 'Math is universal, and now your calculator is too. Nu delivers a seamless experience in your own native script, letting you calculate in the script that feels like home.'
                : 'Experience wealth management with absolute precision and premium design.',
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: const Color(0xff475569),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),

          // Grid of features
          LayoutBuilder(
            builder: (context, constraints) {
              final gridWidth = constraints.maxWidth;
              final crossAxisCount = gridWidth < 600 ? 1 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 160,
                ),
                itemCount: widget.app.features.length,
                itemBuilder: (context, index) {
                  final feature = widget.app.features[index];
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.02),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          feature.title,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff0f172a),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            feature.description,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: const Color(0xff475569),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => widget.app.accentGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              '🔍 How It Works',
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 24 : 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.app.howItWorks ?? '',
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: const Color(0xff475569),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeShowcaseSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => widget.app.accentGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              '🎨 Premium Theme Engine',
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 24 : 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Match your calculator to your mood or device aesthetic with 6 handcrafted themes designed for focus and clarity.',
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: const Color(0xff475569),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),

          // Theme Pills
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: widget.app.themePills.map((theme) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.color.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: theme.color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  theme.label,
                  style: GoogleFonts.outfit(
                    color: theme.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),
          Text(
            '"Simply tap the \'Nu\' logo at the top left to cycle through our signature themes."',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: widget.app.accentColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlossarySection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => widget.app.accentGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              '📚 Glossary of Terms',
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 24 : 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Glossary Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final gridWidth = constraints.maxWidth;
              final crossAxisCount = gridWidth < 600 ? 1 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 120,
                ),
                itemCount: widget.app.glossary.length,
                itemBuilder: (context, index) {
                  final item = widget.app.glossary[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.term,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0f172a),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.definition,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: const Color(0xff475569),
                          height: 1.4,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelinesSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.app.id == 'flux'
                ? 'The FLUX Guide: How to Use'
                : 'User Guidelines',
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 24 : 30,
              fontWeight: FontWeight.w600,
              color: const Color(0xff0f172a),
            ),
          ),
          const SizedBox(height: 12),
          if (widget.app.id == 'flux') ...[
            Text(
              'Using FLUX is intuitive. Follow this simple flow to map out your financial journey:',
              style: GoogleFonts.outfit(
                fontSize: 15,
                color: const Color(0xff475569),
              ),
            ),
            const SizedBox(height: 32),
          ],
          
          // List of Guidelines
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.app.guidelines.length,
            itemBuilder: (context, index) {
              final item = widget.app.guidelines[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Numeral Circle
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: widget.app.accentGradient,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Title and Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff0f172a),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: const Color(0xff475569),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(bool isMobile) {
    return Column(
      children: [
        Text(
          'Get it Today!!',
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w600,
            color: const Color(0xff0f172a),
          ),
        ),
        const SizedBox(height: 24),
        if (widget.app.playStoreUrl != null)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchUrl(widget.app.playStoreUrl!),
              child: Image.asset(
                'assets/web/google_play_badge.png',
                height: 60,
                errorBuilder: (context, error, stackTrace) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    'Get it on Google Play',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.02),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => widget.onNavigate('/'),
                  child: Text(
                    'Home',
                    style: GoogleFonts.outfit(
                      color: const Color(0xff475569),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => widget.onNavigate('/${widget.app.privacyUrl}'),
                  child: Text(
                    'Privacy Policy',
                    style: GoogleFonts.outfit(
                      color: const Color(0xff475569),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (widget.app.deletionUrl != null) ...[
                const SizedBox(width: 24),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => widget.onNavigate('/${widget.app.deletionUrl}'),
                    child: Text(
                      'Data Deletion',
                      style: GoogleFonts.outfit(
                        color: const Color(0xff475569),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 IdeaSpace. All rights reserved.',
            style: GoogleFonts.outfit(
              color: const Color(0xff475569).withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
