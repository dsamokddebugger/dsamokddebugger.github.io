import 'package:flutter/material.dart';
import 'app_model.dart';

final List<AppModel> appsList = [
  const AppModel(
    id: 'nu',
    name: 'Nu',
    tagline: 'Simple Calc (Multiscript)',
    taglineLong: 'Elegance meets global precision',
    logoPath: 'assets/nu/nu.PNG',
    isComingSoon: false,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dsamok.nusimplecalculator',
    privacyUrl: 'nu-privacy.html',
    heroImage: 'assets/nu/nugfeaturegraphic.png',
    problemTitle: 'Why settle for ordinary?',
    problemContent: 'Most calculator apps are cluttered, clinical, and culturally rigid. We believe tools you use every day should be a joy to look at and a reflection of who you are. Nu was built to replace outdated, cluttered stock apps with a workspace designed to inspire focus through elegance.',
    features: [
      FeatureItem(
        title: '20+ Numeral Systems',
        description: 'Choose from Devanagari, Arabic, Bengali, Tamil, Telugu, Thai, Chinese (Han), and many more. No more mental translation; just pure math in your script.',
      ),
      FeatureItem(
        title: 'Instant Switch',
        description: 'Long-press the "Nu" logo/header to open the Script Selection page and transform your calculating experience instantly.',
      ),
      FeatureItem(
        title: 'Smart Precision',
        description: 'Handles massive numbers and long decimals with ease, automatically switching to scientific notation when needed for absolute accuracy.',
      ),
      FeatureItem(
        title: 'Privacy-First',
        description: 'Nu works 100% offline. No tracking, no internet access, and no unnecessary permissions. Your math is your business.',
      ),
    ],
    screenshots: [
      'assets/nu/sc0.jpeg',
      'assets/nu/sc1.jpeg',
      'assets/nu/sc2.jpeg',
      'assets/nu/sc3.jpeg',
      'assets/nu/sc4.jpeg',
      'assets/nu/sc5.jpeg',
    ],
    themePills: [
      ThemePillItem(label: 'Aegis: Futuristic Neon', color: Color(0xff00e5ff)),
      ThemePillItem(label: 'Solara: Minimal Light', color: Color(0xffffca28)),
      ThemePillItem(label: 'Dust: Classic Sepia', color: Color(0xffd7ccc8)),
      ThemePillItem(label: 'Crimson: Bold Focus', color: Color(0xffff5252)),
      ThemePillItem(label: 'Cypher: Digital Matrix', color: Color(0xff00ff41)),
      ThemePillItem(label: 'Ash: Distraction-less Grey', color: Color(0xff9e9e9e)),
    ],
    guidelines: [
      GuidelineItem(
        title: 'Customizing',
        description: 'Tap the logo to cycle themes. Long-press to open the script selector page.',
      ),
      GuidelineItem(
        title: 'Smart Features',
        description: 'Use the () button for grouped operations. Tap % to calculate percentages of your current input.',
      ),
      GuidelineItem(
        title: 'Premium Perks',
        description: 'History icon shows last 10 calculations. Lock icon freezes your current theme and script selection.',
      ),
    ],
    accentColor: Color(0xff64b5f6),
    accentGradient: LinearGradient(
      colors: [Color(0xff64b5f6), Color(0xff1e88e5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const AppModel(
    id: 'flux',
    name: 'Flux',
    tagline: 'Wealth Projector',
    taglineLong: 'Accounting for Inflation in Tomorrow\'s Economy',
    logoPath: 'assets/flux/flux.jpg',
    isComingSoon: false,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dsamok.fluxwealthprojector',
    privacyUrl: 'flux-privacy.html',
    heroImage: 'assets/flux/feature graphic.jpg',
    problemTitle: 'Why most calculators fail.',
    problemContent: 'Welcome to FLUX Wealth Projector, the premier financial visualization tool designed for the modern investor. While most calculators only show the nominal balance in your bank account, FLUX reveals what that money will actually buy you in tomorrow\'s economy by calculating today’s purchasing power.',
    problemContent2: 'Featuring a high-end, cyberpunk-inspired "glassmorphic" interface, FLUX combines rigorous financial modeling with a stunning visual experience.',
    features: [
      FeatureItem(
        title: 'Inflation-Adjusted Reality',
        description: 'Instantly visualize the "Real Value" of your future savings.',
      ),
      FeatureItem(
        title: 'Dynamic Growth Charts',
        description: 'Interactive, glowing data visualizations that track your wealth trajectory.',
      ),
      FeatureItem(
        title: 'Precision Compounding',
        description: 'Advanced math engine supporting Simple and Compound Interest (Daily, Monthly, or Yearly).',
      ),
      FeatureItem(
        title: 'Lifestyle Support Metric',
        description: 'Estimates exactly how many months your savings will fund your projected future lifestyle.',
      ),
      FeatureItem(
        title: 'Real Growth Analytics',
        description: 'View true net gain after accounting for both deposits and inflationary decay.',
      ),
      FeatureItem(
        title: 'Premium Design',
        description: 'Experience a sleek, dark-mode interface with neon accents and fluid animations.',
      ),
    ],
    screenshots: [
      'assets/flux/sc01.jpeg',
      'assets/flux/sc1.jpeg',
      'assets/flux/sc2.jpeg',
      'assets/flux/sc7.jpeg',
      'assets/flux/sc9.jpeg',
    ],
    glossary: [
      GlossaryItem(
        term: 'Inflation-Adjusted Value',
        definition: 'The value of your future wealth expressed in today\'s purchasing power.',
      ),
      GlossaryItem(
        term: 'Future Value',
        definition: 'The total nominal amount of money you will have at the end of the term.',
      ),
      GlossaryItem(
        term: 'Months of Support',
        definition: 'How many months you can live off your savings, based on projected expenses.',
      ),
      GlossaryItem(
        term: 'Future Cost',
        definition: 'An inflation-adjusted projection of what your current lifestyle will cost.',
      ),
      GlossaryItem(
        term: 'Total Invested',
        definition: 'The total principal (Initial + Monthly Deposits) you have contributed.',
      ),
      GlossaryItem(
        term: 'Interest Earned',
        definition: 'The total profit generated by your investment over time.',
      ),
      GlossaryItem(
        term: 'Real Growth',
        definition: 'The net percentage increase in your wealth after inflation and deposits.',
      ),
      GlossaryItem(
        term: 'Compounding',
        definition: 'The process where interest is earned on both principal and accumulated interest.',
      ),
    ],
    guidelines: [
      GuidelineItem(
        title: 'Initial Investment',
        description: 'Adjust the slider to reflect your current starting capital.',
      ),
      GuidelineItem(
        title: 'Monthly Deposit',
        description: 'Set your recurring contribution to see the power of consistency.',
      ),
      GuidelineItem(
        title: 'Annual Return',
        description: 'Enter your expected yearly ROI (Return on Investment).',
      ),
      GuidelineItem(
        title: 'Inflation Rate',
        description: 'Input the projected inflation rate (e.g., 3–4%) to see real-world value.',
      ),
      GuidelineItem(
        title: 'Lifestyle Expense',
        description: 'Enter current cost of living; FLUX projects the future adjusted cost.',
      ),
      GuidelineItem(
        title: 'Time & Mode',
        description: 'Select horizon (up to 50 years) and toggle between Simple/Compound modes.',
      ),
    ],
    accentColor: Color(0xff00ff41), // Custom green neon accent for Flux
    accentGradient: LinearGradient(
      colors: [Color(0xff00ff41), Color(0xff008f11)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const AppModel(
    id: 'amber',
    name: 'Amber',
    tagline: 'Clean, Focused Sudoku',
    taglineLong: 'Clean, Focused Sudoku Puzzles',
    logoPath: 'assets/amber/logo.png',
    placeholderChar: 'A',
    placeholderColor: Color(0xffffb300),
    isComingSoon: false,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dsamok.ambersudoku',
    privacyUrl: 'amber-privacy.html',
    problemTitle: 'Why settle for cluttered puzzles?',
    problemContent: 'AMBER Sudoku is designed to bring you the purest Sudoku experience without distractions. Featuring beautiful typography, local stats tracking, and a distraction-free interface, it\'s the perfect companion for your daily brain exercise.',
    features: [
      FeatureItem(
        title: 'Offline-First Play',
        description: 'Solve puzzles anywhere, anytime. No internet connection required for core gameplay.',
      ),
      FeatureItem(
        title: 'Progress Tracking',
        description: 'Keep track of your current grid state, solutions, move history, and solving timer.',
      ),
      FeatureItem(
        title: 'In-Game Profiles',
        description: 'Set up local profiles (like Leo and Maya) to track your levels, XP, and stats over time.',
      ),
      FeatureItem(
        title: 'Theme & Sound Options',
        description: 'Customize your puzzle board with different themes and sound settings to fit your preferences.',
      ),
    ],
    accentColor: Color(0xffffb300),
    accentGradient: LinearGradient(
      colors: [Color(0xffffb300), Color(0xffff8f00)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const AppModel(
    id: 'omni',
    name: 'Omni',
    tagline: 'Universal Utility Reimagined',
    placeholderChar: 'O',
    placeholderColor: Color(0xff8e24aa),
    isComingSoon: true,
    privacyUrl: 'omni-privacy.html',
  ),
  const AppModel(
    id: 'chess-academy',
    name: 'Chess Academy',
    tagline: 'Dominate the Board',
    taglineLong: 'Engaging & Synchronized Chess Learning',
    logoPath: 'assets/chess-academy/logo.png',
    placeholderChar: 'C',
    placeholderColor: Color(0xff4a5568),
    isComingSoon: false,
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dsamok.ideaspacechess',
    privacyUrl: 'chess-academy-privacy.html',
    deletionUrl: 'chess-academy-deletion.html',
    problemTitle: 'Master Chess with Analytics',
    problemContent: 'IdeaSpace Chess Academy provides a secure, synchronized, and engaging chess-learning experience. Improve your tactical vision, track your cognitive progress on a dynamic dashboard, and test your skills against the powerful Stockfish engine.',
    features: [
      FeatureItem(
        title: 'Stockfish Integration',
        description: 'Play and train against the world-class Stockfish chess engine with custom limit levels.',
      ),
      FeatureItem(
        title: 'Tactical Analytics',
        description: 'Analyze your games and review cognitive tactical analytics displayed on a dynamic Dashboard radar chart.',
      ),
      FeatureItem(
        title: 'Cross-Device Sync',
        description: 'Synchronize your ratings, game logs, and unlocked items across multiple devices using secure cloud database integration.',
      ),
      FeatureItem(
        title: 'Progress Tracking',
        description: 'Track your ELO rating, puzzle completion rates, daily assignment progress, and match history.',
      ),
    ],
    accentColor: Color(0xff90caf9),
    accentGradient: LinearGradient(
      colors: [Color(0xff90caf9), Color(0xff42a5f5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];
