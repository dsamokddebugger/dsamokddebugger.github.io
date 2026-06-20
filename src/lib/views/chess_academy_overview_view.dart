import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/nav_bar.dart';
import '../widgets/programmatic_background.dart';

class ChessAcademyOverviewView extends StatefulWidget {
  final Function(String) onNavigate;

  const ChessAcademyOverviewView({super.key, required this.onNavigate});

  @override
  State<ChessAcademyOverviewView> createState() => _ChessAcademyOverviewViewState();
}

class _ChessAcademyOverviewViewState extends State<ChessAcademyOverviewView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _modesKey = GlobalKey();

  void _scrollToModes() {
    final context = _modesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      body: ProgrammaticBackground(
        child: Column(
          children: [
            // Floating Navbar
            NavBar(
              onNavigate: widget.onNavigate,
              currentRoute: '/chess-academy/index.html',
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 24,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Hero Section
                        _buildHero(isMobile),

                        const SizedBox(height: 80),

                        // Lore / Story Section
                        _buildLoreSection(isMobile),

                        const SizedBox(height: 80),

                        // App Modes Showcase
                        _buildModesSection(isMobile),

                        const SizedBox(height: 100),

                        // Footer
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(bool isMobile) {
    return Column(
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xff6366f1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xff6366f1).withValues(alpha: 0.2)),
          ),
          child: Text(
            'The Last Resistance of Human Strategy',
            style: GoogleFonts.outfit(
              color: const Color(0xff4f46e5),
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 28),

        // Title
        Text(
          'Master the Board with\nAdaptive Intelligence',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.w800,
            color: const Color(0xff0f172a), // Slate-900
            height: 1.15,
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        Container(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'Bridging human intuition with algorithmic calculation using high-performance engines, bare-metal state verification, adaptive AI tutoring, and deep psychological diagnostics.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 15 : 18,
              color: const Color(0xff475569), // Slate-600
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),

        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff6366f1), Color(0xff4f46e5)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff6366f1).withValues(alpha: 0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: () => widget.onNavigate('/chess-academy/manual.html'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Explore Operating Manual',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: _scrollToModes,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xff475569),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                side: const BorderSide(color: Color(0xffcbd5e1), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Explore App Features',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoreSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xffe2e8f0)), // Slate-200
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showSideBySide = constraints.maxWidth > 800;

          final loreText = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff8b5cf6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Apprentice & Grandmaster',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff7c3aed),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Human Instinct vs Machine Tyranny',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0f172a),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'GM Chanakya was once the greatest chess mind in the world. He defeated champions, trained prodigies, and preserved the ancient principles of strategic warfare. But one of his brightest students, who would become known as GM Kingslayer, abandoned intuition and embraced cold machine calculation to seize the world\'s number one position.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: const Color(0xff475569),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Now, rogue AI entities disguised as distinct chess personalities have spread, seeking to assert intellectual superiority and claiming humanity is emotional and unfit to lead. The Academy is humanity\'s final resistance.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: const Color(0xff475569),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xfff8fafc),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                ),
                child: Text(
                  'Apprentice: You are humanity\'s last hope. Under the guidance of GM Chanakya, you must hone your intuition to eventually challenge the AI order.',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xff334155),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          );

          final visualCard = AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff1f5f9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xffe2e8f0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 48,
                    color: Color(0xff6366f1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chanakya vs Kingslayer',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Humanity\'s Final Match Heuristics',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: const Color(0xff64748b),
                    ),
                  ),
                ],
              ),
            ),
          );

          if (showSideBySide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: loreText),
                const SizedBox(width: 48),
                Expanded(flex: 2, child: visualCard),
              ],
            );
          } else {
            return Column(
              children: [
                loreText,
                const SizedBox(height: 32),
                visualCard,
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildModesSection(bool isMobile) {
    final modes = _getModesData();

    return Column(
      key: _modesKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'The Chess Academy Lobby',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 26 : 36,
            fontWeight: FontWeight.w700,
            color: const Color(0xff0f172a),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Explore the 12 core spaces inside the application, designed for custom-tailored gameplay, native analysis, and algorithmic training.',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 15,
            color: const Color(0xff475569),
          ),
        ),
        const SizedBox(height: 48),

        // Grid of modes
        LayoutBuilder(
          builder: (context, constraints) {
            final gridWidth = constraints.maxWidth;
            int crossAxisCount = 3;
            if (gridWidth < 640) {
              crossAxisCount = 1;
            } else if (gridWidth < 900) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 180,
              ),
              itemCount: modes.length,
              itemBuilder: (context, index) {
                final mode = modes[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xffe2e8f0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mode.num,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff6366f1),
                            ),
                          ),
                          Icon(
                            mode.icon,
                            size: 18,
                            color: const Color(0xffcbd5e1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        mode.title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0f172a),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          mode.desc,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: const Color(0xff475569),
                            height: 1.4,
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
                  onTap: () => widget.onNavigate('/chess-academy/manual.html'),
                  child: Text(
                    'Operating Manual',
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
            '© 2026 IdeaSpace. Chess Academy and all materials are properties of IdeaSpace.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: const Color(0xff475569).withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<ModeData> _getModesData() {
    return [
      ModeData('01', 'Home Dashboard', 'Track active daily challenges, rating progress, and visual analytics via your cognitive radar chart.', Icons.dashboard_outlined),
      ModeData('02', 'Assignment', 'Complete specialized tasks dynamically served by GM Chanakya, targeting diagnosed scotomas (blind spots).', Icons.assignment_outlined),
      ModeData('03', 'Arena Matchmaking', 'Play rated matches against 20 custom AI personas, ranging from absolute beginner to ultimate engine apex.', Icons.sports_esports_outlined),
      ModeData('04', 'Battleground', 'A stress-free sandbox mode featuring live evaluation metrics, color switching, and Stockfish self-play.', Icons.science_outlined),
      ModeData('05', 'Academy Lobby', 'Engage in active training games with GM Chanakya, where he adaptively targets your diagnosed weaknesses.', Icons.school_outlined),
      ModeData('06', 'Puzzles', 'Solve targeted tactical puzzles served dynamically based on coordinate-delta blind spot tracking.', Icons.extension_outlined),
      ModeData('07', 'Analysis Lab', 'Examine positions, load custom PGN files, build custom position vectors (FEN), and trace branch variation lines.', Icons.biotech_outlined),
      ModeData('08', 'Game Archive', 'Replay your rated and Academy matches using cinematic replay mode, with instant mistake flagging.', Icons.archive_outlined),
      ModeData('09', 'Tutorial Lobby', 'Work through interactive chess modules spanning three difficulty tiers (Initiate, Scholar, Master).', Icons.class_outlined),
      ModeData('10', 'Settings Control', 'Configure engine threads, time increments, background themes, and modular audio triggers.', Icons.settings_outlined),
      ModeData('11', 'Academy Store', 'Unlock premium boards, custom sound packs, and cosmetic themes using credits earned in matches.', Icons.storefront_outlined),
      ModeData('12', 'About Us (E-Book)', 'Flip through an animated high-fidelity book detailing the manual, core story, and development stack.', Icons.menu_book_outlined),
    ];
  }
}

class ModeData {
  final String num;
  final String title;
  final String desc;
  final IconData icon;

  ModeData(this.num, this.title, this.desc, this.icon);
}
