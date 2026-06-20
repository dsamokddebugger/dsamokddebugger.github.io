import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/nav_bar.dart';
import '../widgets/programmatic_background.dart';

class PrivacyView extends StatefulWidget {
  final Function(String) onNavigate;

  const PrivacyView({super.key, required this.onNavigate});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  int expandedIndex = 0; // Default to general policy expanded

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    final policies = _getPoliciesData();

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      body: ProgrammaticBackground(
        child: Column(
          children: [
            // Unified Floating Navbar
            NavBar(
              onNavigate: widget.onNavigate,
              currentRoute: '/privacy.html',
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    
                    // Header Section
                    Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        children: [
                          Text(
                            'Privacy Hub',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: isMobile ? 32 : 44,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff0f172a),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'We believe in data minimalism. Our apps are built to process your data locally, ensuring privacy by design. Select any policy below to read details.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              color: const Color(0xff475569),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Accordion List of Policies
                    Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: policies.length,
                        itemBuilder: (context, index) {
                          final policy = policies[index];
                          final isExpanded = expandedIndex == index;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: isExpanded 
                                  ? Colors.white 
                                  : Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isExpanded 
                                    ? policy.color.withValues(alpha: 0.4)
                                    : Colors.black.withValues(alpha: 0.06),
                                width: 1.2,
                              ),
                              boxShadow: isExpanded 
                                  ? [
                                      BoxShadow(
                                        color: policy.color.withValues(alpha: 0.04),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                key: PageStorageKey<int>(index),
                                initiallyExpanded: isExpanded,
                                onExpansionChanged: (expanded) {
                                  setState(() {
                                    expandedIndex = expanded ? index : -1;
                                  });
                                },
                                title: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: policy.color.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        policy.icon,
                                        color: policy.color,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            policy.title,
                                            style: GoogleFonts.outfit(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: isExpanded ? const Color(0xff0f172a) : const Color(0xff334155),
                                            ),
                                          ),
                                          if (policy.subtitle.isNotEmpty) ...[
                                            const SizedBox(height: 2),
                                            Text(
                                              policy.subtitle,
                                              style: GoogleFonts.outfit(
                                                fontSize: 12,
                                                color: const Color(0xff475569),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                  color: const Color(0xff475569),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Divider(color: Color(0x0f000000), height: 1),
                                        const SizedBox(height: 20),
                                        
                                        // Markdown-like Text
                                        ...policy.sections.map((section) => _buildSection(section)),
                                        
                                        const SizedBox(height: 12),
                                        
                                        // Action / Download / External Link
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () => widget.onNavigate(policy.staticPath),
                                              icon: const Icon(Icons.open_in_new_rounded, size: 16),
                                              label: Text(
                                                'View Static HTML Version',
                                                style: GoogleFonts.outfit(fontSize: 13),
                                              ),
                                              style: TextButton.styleFrom(
                                                foregroundColor: policy.color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 80),

                    // Standard Footer
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(PolicySection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.heading.isNotEmpty) ...[
            Text(
              section.heading,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff0f172a),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            section.body,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: const Color(0xff475569),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
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
                      color: const Color(0xff0f172a),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
              color: const Color(0xff475569).withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<PolicyItem> _getPoliciesData() {
    return [
      PolicyItem(
        title: 'IdeaSpace General Privacy Policy',
        subtitle: 'Applies to all IdeaSpace applications',
        icon: Icons.shield_outlined,
        color: const Color(0xff6366f1),
        staticPath: 'privacy.html',
        sections: [
          PolicySection(
            heading: '1. Information Collection and Use',
            body: 'At IdeaSpace, we are committed to providing powerful utility tools while ensuring your digital privacy is respected. We believe in data minimalism. Our apps do not require you to create an account or provide identifiable information to access core features. All calculations, progress, or personal settings you enter within our apps are processed exclusively on your device.',
          ),
          PolicySection(
            heading: '2. Third-Party Services',
            body: 'To support the development and maintenance of our free applications, we use third-party services that may collect anonymous information for ads or crash diagnostics, including Google Play Services, AdMob (to display ads using anonymous device identifiers), and Firebase Analytics (to understand general usage pattern data).',
          ),
          PolicySection(
            heading: '3. Device Permissions',
            body: 'Our applications may request basic permissions necessary for functionality, such as Internet Access (for displaying advertisements or framework updates) and Device Storage (only if a specific feature requires saving files locally on your device). We do not access your contacts, photos, or location unless a feature explicitly requires it.',
          ),
        ],
      ),
      PolicyItem(
        title: 'Nu: Simple Calculator',
        subtitle: 'Multiscript calculation suite',
        icon: Icons.calculate_outlined,
        color: const Color(0xff64b5f6),
        staticPath: 'nu-privacy.html',
        sections: [
          PolicySection(
            heading: '1. Data Collection and Usage',
            body: 'Nu is designed as a local utility tool. We do not require users to provide any personal data. The app is fully functional without any account registration. All mathematical inputs and results are processed locally on your device; we do not store, transmit, or have access to any of the numbers you enter.',
          ),
          PolicySection(
            heading: '2. Permissions',
            body: 'Nu requests minimal permissions: Internet Access (necessary for loading ad content and framework updates) and Vibration Control (for haptic feedback if enabled in settings). We do not request access to your contacts, photos, camera, or location.',
          ),
        ],
      ),
      PolicyItem(
        title: 'Flux: Wealth Projector',
        subtitle: 'Financial planning & projection',
        icon: Icons.show_chart_rounded,
        color: const Color(0xff00ff41),
        staticPath: 'flux-privacy.html',
        sections: [
          PolicySection(
            heading: '1. Zero-Data Philosophy',
            body: 'Flux does not collect, store, or sell your private information. There are no user account registration requirements. Every calculation, savings rate, and financial projection is processed entirely on your device. Generated PDF reports and financial charts are saved locally to your device storage.',
          ),
          PolicySection(
            heading: '2. In-App Purchases & Payments',
            body: 'Flux offers optional premium features. All transactions are handled securely by Google Play Billing. We never see or store your credit card numbers, bank details, or billing address. Google simply notifies us that your purchase was successful.',
          ),
          PolicySection(
            heading: '3. Device Permissions',
            body: 'Flux requires Storage & Printing permissions (to save wealth reports as PDFs or send them to a printer), Network Access (to verify premium subscriptions and display ads), and Vibration Control (to provide tactile feedback during sliders/buttons interaction).',
          ),
        ],
      ),
      PolicyItem(
        title: 'Amber Sudoku',
        subtitle: 'Distraction-free classic Sudoku',
        icon: Icons.grid_on_rounded,
        color: const Color(0xffffb300),
        staticPath: 'amber-privacy.html',
        sections: [
          PolicySection(
            heading: '1. Overview and Data Storage',
            body: 'AMBER Sudoku is a mobile application developed using Flutter. It is a puzzle game that operates primarily offline. The app stores game progress, solving timers, local user profiles (e.g. Leo and Maya levels and XP), and settings locally on your device using SharedPreferences. This data is not transmitted to any external servers.',
          ),
          PolicySection(
            heading: '2. Automatically Collected Data',
            body: 'The app integrates Google Mobile Ads (AdMob) for monetization, which may collect Advertising IDs (AAID/IDFA) and coarse location to show ads. It also downloads fonts dynamically via Google Fonts, which may process IP addresses to deliver typography styles.',
          ),
        ],
      ),
      PolicyItem(
        title: 'Chess Academy',
        subtitle: 'Synchronized chess learning & tactics',
        icon: Icons.extension_rounded,
        color: const Color(0xff90caf9),
        staticPath: 'chess-academy-privacy.html',
        sections: [
          PolicySection(
            heading: '1. Information We Collect',
            body: 'If you sign in using Google Authentication, we collect your name, email address, and profile picture. If you choose to use the App in "Anonymous" mode, no personal authentication details are collected. We also store gameplay progress data (ELO ratings, puzzle completion rates, match logs, board configurations, Stockfish engine limits) to synchronize your profile across devices.',
          ),
          PolicySection(
            heading: '2. Data Storage and Security',
            body: 'Your synchronized game profiles, analytics, and authentication tokens are managed securely through Firebase Cloud Services. Offline configurations are stored locally on your device. All communication between the app and Firebase is protected using industry-standard SSL/TLS encryption.',
          ),
          PopupPrivacySection(
            heading: '3. Data Control and Deletion Rights',
            body: 'You have complete control over your personal data. You may request an export of your collected chess profile data, or request the complete and permanent deletion of your authentication account, ratings, and match history. You can submit deletion requests via the Account Deletion Page in the app menu or email apps@ideaspaceapps.store.',
          ),
        ],
      ),
    ];
  }
}

class PolicyItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String staticPath;
  final List<PolicySection> sections;

  PolicyItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.staticPath,
    required this.sections,
  });
}

class PolicySection {
  final String heading;
  final String body;

  PolicySection({required this.heading, required this.body});
}

class PopupPrivacySection extends PolicySection {
  PopupPrivacySection({required super.heading, required super.body});
}
