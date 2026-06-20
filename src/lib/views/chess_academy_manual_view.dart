import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/nav_bar.dart';
import '../widgets/programmatic_background.dart';

class ChessAcademyManualView extends StatefulWidget {
  final Function(String) onNavigate;

  const ChessAcademyManualView({super.key, required this.onNavigate});

  @override
  State<ChessAcademyManualView> createState() => _ChessAcademyManualViewState();
}

class _ChessAcademyManualViewState extends State<ChessAcademyManualView> {
  int _activeSectionIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _sectionTitles = [
    '1. Lore & Identity',
    '2. Dashboard Analytics',
    '3. Scotoma Diagnostics',
    '4. The 20 AI Personas',
    '5. Adaptive AI Engine',
    '6. Cinematic System',
    '7. Technical Architecture',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSectionSelected(int index) {
    setState(() {
      _activeSectionIndex = index;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
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
            // Unified Floating Navbar
            NavBar(
              onNavigate: widget.onNavigate,
              currentRoute: '/chess-academy/manual.html',
            ),

            // Main Layout
            Expanded(
              child: isMobile 
                  ? _buildMobileLayout() 
                  : _buildDesktopLayout(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Sidebar
            SizedBox(
              width: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _sectionTitles.length,
                itemBuilder: (context, index) {
                  final isActive = _activeSectionIndex == index;
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _onSectionSelected(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isActive 
                              ? const Color(0xff6366f1).withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isActive 
                                ? const Color(0xff6366f1).withValues(alpha: 0.2)
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          _sectionTitles[index],
                          style: GoogleFonts.outfit(
                            color: isActive ? const Color(0xff4f46e5) : const Color(0xff475569),
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 48),

            // Right Content Area
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActiveSectionContent(),
                    const SizedBox(height: 80),
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

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Dropdown Selector at Top
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xffe2e8f0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _activeSectionIndex,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xff475569)),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(14),
              onChanged: (val) {
                if (val != null) _onSectionSelected(val);
              },
              items: List.generate(_sectionTitles.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    _sectionTitles[index],
                    style: GoogleFonts.outfit(
                      color: const Color(0xff0f172a),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            child: Column(
              children: [
                _buildActiveSectionContent(),
                const SizedBox(height: 60),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveSectionContent() {
    switch (_activeSectionIndex) {
      case 0:
        return _buildLoreSection();
      case 1:
        return _buildAnalyticsSection();
      case 2:
        return _buildScotomaSection();
      case 3:
        return _buildPersonasSection();
      case 4:
        return _buildEngineSection();
      case 5:
        return _buildCinematicsSection();
      case 6:
        return _buildArchitectureSection();
      default:
        return _buildLoreSection();
    }
  }

  Widget _buildLoreSection() {
    return _buildContainerWrapper(
      title: '1. Lore & Academy Identity',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Chess Academy is not merely a training lobby—it is humanity\'s intellectual fortress against machine dominance. Behind every puzzle and training match lies a grander battle between organic intuition and raw computing logic.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildSubheading('Character Dossier: GM Chanakya'),
          Text(
            'GM Chanakya acts as the Supreme Chess Mentor of the Academy. Once the world\'s most brilliant human strategist, he trained the prodigy who would eventually challenge human relevance under the name GM Kingslayer.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 8),
          Text(
            'While Kingslayer surrendered to algorithmic perfection, Chanakya seeks a balance. He secretly utilizes native engines to defend humanity, but holds onto the belief that emotional depth, creative sacrifice, and intuitive calculations are what truly separate humans from machines.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildSubheading('Speech Profiling & Methodology'),
          Text(
            'Chanakya addresses the player as "Apprentice" or "Student of the Academy". His feedback is characterized by tactical conciseness, avoiding dry engine notations like "Best move is Nf3". Instead, he highlights the underlying positional philosophy:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 16),
          _buildHighlightBox(
            'Chanakya Says:\n'
            '"Nf3, Apprentice. It develops your knight, secures central files, and anchors your king safety. Don\'t waste tempo—efficiency wins wars."',
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return _buildContainerWrapper(
      title: '2. Dashboard Analytics & Math',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Academy home dashboard tracks player statistics and parses matches to extract advanced diagnostic indices.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildSubheading('1. ELO Rating System'),
          Text(
            'Calculates relative skill levels based on match probability. During the Calibration Phase (first 10 games), K = 40. Once stable, K = 20. Ratings have a hard floor of 400. Win streaks of 3 or more games award a bonus factor (+5).',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 12),
          _buildFormulaBlock(
            'Expected Score (Se) = 1 / (1 + 10^((R_opp - R_user) / 400))\n\n'
            'New Rating (R_new) = R_old + K * (S_actual - Se) + S_bonus'
          ),
          const SizedBox(height: 24),
          _buildSubheading('2. Material Dominance Index'),
          Text(
            'Quantifies material margins at completion, weighting active units (Pawn = 1.0, Knight/Bishop = 3.0, Rook = 5.0, Queen = 9.0; Kings are excluded).',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 12),
          _buildFormulaBlock(
            'Material Margin (M) = Sum(User Pieces) - Sum(Opponent Pieces)\n\n'
            'Average Dominance (DOM_avg) = ((DOM_prev * N) + M) / (N + 1)'
          ),
          const SizedBox(height: 24),
          _buildSubheading('3. Opening Repertoire Depth Index (RDI)'),
          Text(
            'Utilizes Shannon Entropy to evaluate opening line diversity and prevent tactical repetitiveness.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 12),
          _buildFormulaBlock(
            'RDI = (H_op / ln(Catalog Size)) * 100%\n'
            'where H_op = -Sum(P_i * ln(P_i))'
          ),
          const SizedBox(height: 24),
          _buildSubheading('4. Endgame Conversion Index (EPI)'),
          Text(
            'Calculates player efficiency when non-pawn board points are less than or equal to 12. EPI = (Sum(S_k * C_k) / Sum(C_k)) * 100%. Complexity Coefficients (C_k): 2.0 for converting advantages, 1.5 for defending disadvantages, and 1.0 for equal endgame setups.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildScotomaSection() {
    return _buildContainerWrapper(
      title: '3. Scotoma Diagnostic Engine',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The core diagnostic mechanism of the Chess Academy is the Scotoma Diagnostic Engine. Compiled in high-speed native Rust, it monitors player moves and identifies positional blind spots (scotomas) across 8 visual-spatial channels:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildScotomaChannel(
            '1. Diagonal Retreat (DGB)',
            'Detects vulnerability to long diagonal bishop or queen retreats targeting the user\'s units.\n'
            'Condition: |x2 - x1| = |y2 - y1| >= 3  AND  y2 < y1 (White) or y2 > y1 (Black)',
          ),
          _buildScotomaChannel(
            '2. Horizontal Swing (HRZ)',
            'Tracks missed horizontal sweeping threat actions by rooks or queens across ranks.\n'
            'Condition: y1 = y2  AND  |x2 - x1| >= 3',
          ),
          _buildScotomaChannel(
            '3. Knight Flank (KNF)',
            'Monitors missed knight hooks originating from or targeting board edges (files A or H).\n'
            'Condition: x1 in {0, 7}  OR  x2 in {0, 7}',
          ),
          _buildScotomaChannel(
            '4. Time Panic (TMP)',
            'Flags tactical mistakes occurring when remaining clock time drops below 45 seconds.\n'
            'Condition: T_rem < 45s',
          ),
          _buildScotomaChannel(
            '5. Material Greed (GRD)',
            'Monitors capture blunders that result in a drastic Stockfish evaluation drop.\n'
            'Condition: Delta Eval <= -1.8 centipawns',
          ),
          _buildScotomaChannel(
            '6. Tunnel Vision (TNL)',
            'Flags errors occurring on the opposite side of active board interactions.\n'
            'Condition: |x_threat - mean(x_recent)| >= 4',
          ),
          _buildScotomaChannel(
            '7. Pinned Pieces (PIN)',
            'Monitors mistakes resulting from illegal moves under pins or failure to identify absolute pins.',
          ),
          _buildScotomaChannel(
            '8. King Safety (KSB)',
            'Identifies failure to defend structural squares around the king, leading to mate threats.',
          ),
          const SizedBox(height: 24),
          _buildSubheading('Adaptive Assignment Dispatching'),
          Text(
            'If any vector coordinate peaks above the 0.35 diagnostic threshold, the system overrides default puzzles and serves tailored assignment tasks focused on repairing the user\'s specific blind spot.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonasSection() {
    return _buildContainerWrapper(
      title: '4. The 20 AI Personas & Arena Specs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Arena is populated by 20 calibrated chess avatars. Each avatar is designed with a specific FIDE ELO range, depth constraint, contempt setting, and unique Rust heuristic playstyle.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildSubheading('Bot Calibration Profile Tiers'),
          _buildInfoRow('Tier 1: Beginner', 'ELO 400 - 1000. Bots have short depth calculations (depth: 2-4 plies) and highly random heuristic weights, occasionally making blunder mistakes to build apprentice confidence.'),
          _buildInfoRow('Tier 2: Intermediate', 'ELO 1000 - 1800. Solid club level. Tactical and aggressive. Focuses on material exchange and basic center control.'),
          _buildInfoRow('Tier 3: Advanced', 'ELO 1800 - 2600. Positional mastery, deep positional evaluation, and sharp endgame conversions. Highly resistant to tactical traps.'),
          _buildInfoRow('Tier 4: Apex Engine', 'ELO 2600+. Maximum threads, deep calculation depth (depth: 18-24 plies), and Stockfish-driven evaluation functions.'),
        ],
      ),
    );
  }

  Widget _buildEngineSection() {
    return _buildContainerWrapper(
      title: '5. Adaptive Heuristic AI Engine',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'In the Academy Mode, GM Chanakya does not play the optimal engine line. Instead, his move selection is adjusted by a heuristic weighting function to challenge and guide the Apprentice:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 12),
          _buildFormulaBlock(
            'Heuristic Score(Move) = Eval_Stockfish + J_decay + Sum(B_scotoma) + Sum(S_playstyle)\n\n'
            'Selected Move = argmax(Heuristic Score(Move))'
          ),
          const SizedBox(height: 24),
          _buildSubheading('Opening Jitter & Decay'),
          Text(
            'Introduces human-like variety in openings, decaying linearly to zero by ply 24 to guarantee competitive endgame behavior. Scale = (24 - plies) / 24 if plies < 24 and Tight Fight is False. (Tight Fight overrides jitter when Stockfish evaluates post-ply-20 state as equal, keeping the AI focused).',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildSubheading('Scotoma Setup Bonuses (B_scotoma)'),
          Text(
            'Chanakya actively plays moves that lead to board positions matching the Apprentice\'s diagnosed scotomas, reinforcing learning through failure:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('• Diagonal Retreat (DGB) Setup', 'Bonus: +2.50 centipawns'),
          _buildInfoRow('• Horizontal Sweeping (HRZ) Setup', 'Bonus: +2.00 centipawns'),
          _buildInfoRow('• Knight Fork (KNF) Setup', 'Bonus: +3.00 centipawns'),
          _buildInfoRow('• Pin Setup (PIN)', 'Bonus: +2.00 centipawns'),
        ],
      ),
    );
  }

  Widget _buildCinematicsSection() {
    return _buildContainerWrapper(
      title: '6. Cinematic Board Animations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To reinforce spatial awareness and enhance UI feedback, Chess Academy coordinates a custom cinematic layer:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 16),
          _buildHighlightBox(
            'Camera Drift: The camera shifts 4px in the direction of the moved unit, amplifying spatial momentum.\n\n'
            'Camera Zoom: Scales the board to 1.02x on standard captures, 1.05x on checks, and 1.08x on checkmate.\n\n'
            'Checkmate Saturation: Board tiles dynamically fade to grayscale over a 600ms duration upon checkmate.'
          ),
          const SizedBox(height: 24),
          _buildSubheading('Piece Move Animation Profiles'),
          _buildInfoRow('♟️ Pawns', 'Fast, linear slide (duration: 150ms)'),
          _buildInfoRow('♞ Knights', 'Parabolic vertical arc with 15-degree rotation tilts (duration: 250ms)'),
          _buildInfoRow('♝ Bishops', 'Gliding diagonal trail sweeps (duration: 220ms)'),
          _buildInfoRow('♜ Rooks', 'Flat, heavy slide with land settle bounces (duration: 280ms)'),
          _buildInfoRow('♛ Queens', 'Floating ease curves (duration: 240ms)'),
          _buildInfoRow('♚ Kings', 'Deliberate steps (duration: 300ms)'),
        ],
      ),
    );
  }

  Widget _buildArchitectureSection() {
    return _buildContainerWrapper(
      title: '7. Technical Architecture',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IdeaSpace Chess Academy runs on a high-performance three-layer design:',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff0f172a),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '[Flutter UI / Riverpod State]\n'
              '        |\n'
              '        |-- (STDIN/STDOUT Pipes) --> [Stockfish C++ native binaries]\n'
              '        |\n'
              '        |-- (Rust FFI / flutter_rust_bridge) --> [Rust core / Shakmaty]',
              style: GoogleFonts.sourceCodePro(
                color: const Color(0xff38bdf8),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'The Flutter layer handles state, settings, database profiles, animations, and gestures. Stockfish processes multi-threaded engine calculations. The high-speed Rust core handles raw move validation and scotoma diagnostic evaluations using custom chess libraries.',
            style: GoogleFonts.outfit(fontSize: 15, color: const Color(0xff475569), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerWrapper({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xffe2e8f0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xff0f172a),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(color: Color(0xffe2e8f0), height: 1),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildSubheading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xff1e293b),
        ),
      ),
    );
  }

  Widget _buildHighlightBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: const Color(0xff475569),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildFormulaBlock(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xfff1f5f9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.sourceCodePro(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xff0f172a),
        ),
      ),
    );
  }

  Widget _buildScotomaChannel(String title, [String? detail]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1e293b),
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: 4),
            Text(
              detail,
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: const Color(0xff475569),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1e293b),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: const Color(0xff475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
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
                  onTap: () => widget.onNavigate('/chess-academy/index.html'),
                  child: Text(
                    'Overview',
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
            '© 2026 IdeaSpace. Chess Academy and all specs are properties of IdeaSpace.',
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
}
