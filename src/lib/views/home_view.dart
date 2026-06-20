import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/apps_data.dart';
import '../models/app_model.dart';
import '../widgets/programmatic_background.dart';
import '../widgets/nav_bar.dart';

class HomeView extends StatefulWidget {
  final Function(String) onNavigate;

  const HomeView({super.key, required this.onNavigate});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xff09090b),
      body: ProgrammaticBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Navigation Bar
              NavBar(
                onNavigate: widget.onNavigate,
                currentRoute: '/',
              ),

              // Hero & App Collection Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Hero Icon (Clean and premium)
                    Container(
                      width: isMobile ? 100 : 130,
                      height: isMobile ? 100 : 130,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.05),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff6366f1).withValues(alpha: 0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'assets/web/icon.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Welcoming Header
                    Text(
                      'IdeaSpace',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 36 : 48,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff0f172a), // Slate-900
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        'Delightfully simple apps that do one thing perfectly.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 22 : 32,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff6366f1), // Indigo Accent
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 650),
                      child: Text(
                        'Say goodbye to clutter and hello to effortless, single-task solutions.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff475569), // Slate-600
                          height: 1.5,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 64),

                    // Section Divider Label
                    Text(
                      'OUR COLLECTION',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff94a3b8),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Collection Grid
                    _buildCollectionGrid(isMobile),
                  ],
                ),
              ),

              const SizedBox(height: 120),

              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionGrid(bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            _AppCard(app: appsList[0], onNavigate: widget.onNavigate),
            const SizedBox(height: 20),
            _AppCard(app: appsList[1], onNavigate: widget.onNavigate),
            const SizedBox(height: 20),
            _AppCard(app: appsList[2], onNavigate: widget.onNavigate),
            const SizedBox(height: 20),
            _AppCard(app: appsList[3], onNavigate: widget.onNavigate),
          ],
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AppCard(app: appsList[0], onNavigate: widget.onNavigate),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: _AppCard(app: appsList[1], onNavigate: widget.onNavigate),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AppCard(app: appsList[2], onNavigate: widget.onNavigate),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: _AppCard(app: appsList[3], onNavigate: widget.onNavigate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
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
                  onTap: () => widget.onNavigate('/privacy.html'),
                  child: Text(
                    'Privacy Policy',
                    style: GoogleFonts.outfit(
                      color: const Color(0xff475569),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 IdeaSpace. All rights reserved.',
            style: GoogleFonts.outfit(
              color: const Color(0xff94a3b8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppCard extends StatefulWidget {
  final AppModel app;
  final Function(String) onNavigate;

  const _AppCard({
    required this.app,
    required this.onNavigate,
  });

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Fetch description based on the app ID
    String gist = '';
    if (widget.app.id == 'nu') {
      gist = 'A stunning, minimalist calculator supporting 20+ numeral systems. Cycle through handcrafted themes and calculate effortlessly in your native script.';
    } else if (widget.app.id == 'flux') {
      gist = 'A premium wealth projector adjusting future savings for inflation. Visualize compound interest and track your real future purchasing power.';
    } else if (widget.app.id == 'amber') {
      gist = 'A clean, distraction-free Sudoku puzzle experience. Solve offline, track your local profile stats, and focus completely on the game.';
    } else if (widget.app.id == 'chess-academy') {
      gist = 'Dominate the board with Stockfish-powered chess training. Sync ratings across devices and monitor cognitive growth on a dynamic analytics dashboard.';
    }

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onNavigate('/${widget.app.id}.html'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, isHovered ? -8.0 : 0.0, 0.0),
          padding: const EdgeInsets.all(28),
          constraints: const BoxConstraints(minHeight: 250),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered 
                  ? widget.app.accentColor.withValues(alpha: 0.8) 
                  : Colors.black.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? widget.app.accentColor.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: isHovered ? 30 : 20,
                offset: isHovered ? const Offset(0, 16) : const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo & Info
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: widget.app.logoPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  widget.app.logoPath!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Center(
                                child: Text(
                                  widget.app.placeholderChar ?? widget.app.name[0],
                                  style: GoogleFonts.outfit(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: widget.app.placeholderColor,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.app.name,
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff0f172a),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.app.tagline,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: widget.app.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    gist,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: const Color(0xff475569),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isHovered ? widget.app.accentColor : const Color(0xff475569),
                    ),
                    child: const Text('Explore App'),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: isHovered ? widget.app.accentColor : const Color(0xff475569),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
