import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/apps_data.dart';
import 'contact_dialog.dart';

class NavBar extends StatefulWidget {
  final Function(String) onNavigate;
  final String currentRoute;

  const NavBar({
    super.key,
    required this.onNavigate,
    required this.currentRoute,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? hoveredAppId;
  bool isMenuHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        constraints: const BoxConstraints(maxWidth: 1100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.75), // Glassmorphic White
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.08),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo/Branding
                  _buildBrand(),

                  // App shortcuts (Desktop only)
                  if (!isMobile) _buildAppSwitcher(),

                  // Navigation Links / Mobile Menu
                  if (!isMobile)
                    _buildNavLinks(context)
                  else
                    _buildMobileMenu(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onNavigate('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Glowing Purple/Indigo Dot as a clean professional icon
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xff6366f1), Color(0xffa855f7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff6366f1).withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'IdeaSpace',
              style: GoogleFonts.outfit(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: const Color(0xff0f172a), // Slate-900
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSwitcher() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: appsList.map((app) {
          final isHovered = hoveredAppId == app.id;
          final isCurrent = widget.currentRoute == '/${app.id}.html';

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => hoveredAppId = app.id),
            onExit: (_) => setState(() => hoveredAppId = null),
            child: GestureDetector(
              onTap: () => widget.onNavigate('/${app.id}.html'),
              child: Tooltip(
                message: app.name,
                textStyle: GoogleFonts.outfit(color: Colors.white, fontSize: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff0f172a),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isCurrent 
                        ? app.accentColor.withValues(alpha: 0.15)
                        : (isHovered ? Colors.black.withValues(alpha: 0.05) : Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCurrent
                          ? app.accentColor.withValues(alpha: 0.4)
                          : (isHovered ? Colors.black.withValues(alpha: 0.08) : Colors.transparent),
                      width: 1.2,
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: app.logoPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            app.logoPath!,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Center(
                          child: Text(
                            app.placeholderChar ?? app.name[0],
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isCurrent ? app.accentColor : const Color(0xff64748b), // Slate-500
                            ),
                          ),
                        ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavLinks(BuildContext context) {
    final isPrivacy = widget.currentRoute == '/privacy.html';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Privacy Policy Link
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => widget.onNavigate('/privacy.html'),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.outfit(
                color: isPrivacy ? const Color(0xff0f172a) : const Color(0xff475569), // Slate-900 / Slate-600
                fontSize: 14,
                fontWeight: isPrivacy ? FontWeight.w600 : FontWeight.w500,
              ),
              child: const Text('Privacy Policy'),
            ),
          ),
        ),
        const SizedBox(width: 24),

        // Contact Us Link (Styled as a clean professional button)
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ContactDialog(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: Text(
                'Contact Us',
                style: GoogleFonts.outfit(
                  color: const Color(0xff0f172a), // Slate-900
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded, color: Color(0xff475569)), // Slate-600
      tooltip: 'Show Menu',
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
      ),
      offset: const Offset(0, 48),
      onSelected: (value) {
        if (value == 'contact') {
          showDialog(
            context: context,
            builder: (context) => const ContactDialog(),
          );
        } else {
          widget.onNavigate(value);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: '/',
          child: Row(
            children: [
              const Icon(Icons.home_outlined, size: 18, color: Color(0xff64748b)), // Slate-500
              const SizedBox(width: 12),
              Text(
                'Home',
                style: GoogleFonts.outfit(color: const Color(0xff0f172a), fontSize: 14), // Slate-900
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        ...appsList.map((app) => PopupMenuItem(
              value: '/${app.id}.html',
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: app.accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: app.logoPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(app.logoPath!),
                          )
                        : Center(
                            child: Text(
                              app.placeholderChar ?? app.name[0],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: app.accentColor,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    app.name,
                    style: GoogleFonts.outfit(color: const Color(0xff0f172a), fontSize: 14), // Slate-900
                  ),
                ],
              ),
            )),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: '/privacy.html',
          child: Row(
            children: [
              const Icon(Icons.privacy_tip_outlined, size: 18, color: Color(0xff64748b)),
              const SizedBox(width: 12),
              Text(
                'Privacy Policy',
                style: GoogleFonts.outfit(color: const Color(0xff0f172a), fontSize: 14),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'contact',
          child: Row(
            children: [
              const Icon(Icons.mail_outline_rounded, size: 18, color: Color(0xff64748b)),
              const SizedBox(width: 12),
              Text(
                'Contact Us',
                style: GoogleFonts.outfit(color: const Color(0xff0f172a), fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
