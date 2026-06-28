import 'package:flutter/material.dart';

class FeatureItem {
  final String title;
  final String description;

  const FeatureItem({required this.title, required this.description});
}

class GlossaryItem {
  final String term;
  final String definition;

  const GlossaryItem({required this.term, required this.definition});
}

class ThemePillItem {
  final String label;
  final Color color;

  const ThemePillItem({required this.label, required this.color});
}

class GuidelineItem {
  final String title;
  final String description;

  const GuidelineItem({required this.title, required this.description});
}

class SubPageLink {
  final String title;
  final String url;
  final IconData icon;

  const SubPageLink({
    required this.title,
    required this.url,
    required this.icon,
  });
}

class AppModel {
  final String id;
  final String name;
  final String tagline;
  final String? taglineLong;
  final String? logoPath; // if null, use placeholder character
  final String? placeholderChar;
  final Color placeholderColor;
  final bool isComingSoon;
  final String? playStoreUrl;
  final String privacyUrl;
  final String? deletionUrl;
  final String? heroImage;
  
  final String? problemTitle;
  final String? problemContent;
  final String? problemContent2;
  final String? howItWorks;
 
  final List<FeatureItem> features;
  final List<String> screenshots;
  final List<ThemePillItem> themePills;
  final List<GlossaryItem> glossary;
  final List<GuidelineItem> guidelines;
  final List<SubPageLink> subPageLinks;
 
  final Color accentColor;
  final LinearGradient accentGradient;
 
  const AppModel({
    required this.id,
    required this.name,
    required this.tagline,
    this.taglineLong,
    this.logoPath,
    this.placeholderChar,
    this.placeholderColor = Colors.blueGrey,
    this.isComingSoon = false,
    this.playStoreUrl,
    required this.privacyUrl,
    this.deletionUrl,
    this.heroImage,
    this.problemTitle,
    this.problemContent,
    this.problemContent2,
    this.howItWorks,
    this.features = const [],
    this.screenshots = const [],
    this.themePills = const [],
    this.glossary = const [],
    this.guidelines = const [],
    this.subPageLinks = const [],
    this.accentColor = const Color(0xff64b5f6),
    this.accentGradient = const LinearGradient(
      colors: [Color(0xff64b5f6), Color(0xff1e88e5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  });
}
