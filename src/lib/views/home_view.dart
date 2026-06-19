import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/apps_data.dart';
import '../models/app_model.dart';

class HomeView extends StatefulWidget {
  final Function(String) onNavigate;

  const HomeView({super.key, required this.onNavigate});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? hoveredAppId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xff0a0a0a),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/web/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromARGB(220, 10, 10, 10), // 85% opacity overlay
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Navigation (No branding, clean & empty as requested)
              const SizedBox(height: 80),

              // Hero Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Hero Icon (Large icon)
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? 320 : 480,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(isMobile ? 50 : 80),
                        child: Image.asset(
                          'assets/web/icon.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Opaque Card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xff161616),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Building the Future of Utility Apps',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: isMobile ? 18 : 22,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xff94a3b8),
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Try our latest apps',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff94a3b8).withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // App Selector Tabs
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 20,
                            children: appsList.map((app) => _buildAppTab(app)).toList(),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildAppTab(AppModel app) {
    final isHovered = hoveredAppId == app.id;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredAppId = app.id),
      onExit: (_) => setState(() => hoveredAppId = null),
      child: GestureDetector(
        onTap: () => widget.onNavigate('/${app.id}.html'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: 80,
          child: Column(
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isHovered ? const Color(0xff1c1c1c) : const Color(0xff161616),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isHovered ? const Color(0xff64b5f6) : Colors.white.withValues(alpha: 0.05),
                  ),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: const Color(0xff64b5f6).withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [],
                ),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: app.logoPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          app.logoPath!,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Text(
                        app.placeholderChar ?? app.name[0],
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff94a3b8),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              // Name
              Text(
                app.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isHovered ? Colors.white : const Color(0xff94a3b8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.3),
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
                      color: const Color(0xff94a3b8),
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
                      color: const Color(0xff94a3b8),
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
              color: const Color(0xff94a3b8).withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
