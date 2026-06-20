import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/apps_data.dart';
import 'views/home_view.dart';
import 'views/app_detail_view.dart';

void main() {
  // Use path URL strategy (removes the '#' from the URL path)
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdeaSpace | Building the Future',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff64b5f6),
        scaffoldBackgroundColor: const Color(0xff0a0a0a),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff64b5f6),
          surface: Color(0xff0a0a0a),
        ),
      ),
      // Define routing based on window.location.pathname
      onGenerateRoute: (settings) {
        final path = settings.name ?? '/';
        
        // Match specific routes
        if (path == '/' || path == '/index.html') {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => HomeView(
              onNavigate: (route) => _handleNavigation(context, route),
            ),
          );
        }

        // Match app detail pages (e.g. /nu.html, /flux.html)
        final appId = _extractAppId(path);
        if (appId != null) {
          final app = appsList.firstWhere(
            (a) => a.id == appId,
            orElse: () => appsList.first,
          );
          
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => AppDetailView(
              app: app,
              onNavigate: (route) => _handleNavigation(context, route),
            ),
          );
        }

        // Fallback to Home View
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => HomeView(
            onNavigate: (route) => _handleNavigation(context, route),
          ),
        );
      },
    );
  }

  // Extracts the app id from paths like "/nu.html" or "/nu"
  String? _extractAppId(String path) {
    final cleanPath = path.replaceAll('/', '').replaceAll('.html', '');
    for (final app in appsList) {
      if (app.id == cleanPath) {
        return app.id;
      }
    }
    return null;
  }

  // Shared navigation logic
  void _handleNavigation(BuildContext context, String route) {
    if (route.endsWith('-privacy.html') || 
        route.endsWith('-deletion.html') || 
        route == '/privacy.html') {
      // If it is a static HTML page (privacy or deletion policy), load it directly in the browser
      final cleanRoute = route.startsWith('/') ? route.substring(1) : route;
      launchUrl(
        Uri.base.resolve(cleanRoute),
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_self',
      );
    } else {
      // Navigate internally in Flutter
      Navigator.of(context).pushNamed(route);
    }
  }
}
