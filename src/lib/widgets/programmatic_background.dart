import 'package:flutter/material.dart';

class ProgrammaticBackground extends StatelessWidget {
  final Widget child;

  const ProgrammaticBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base light color (Slate-50)
        Positioned.fill(
          child: Container(
            color: const Color(0xfff8fafc),
          ),
        ),
        // Soft top-center radial gradient glow
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -1.0), // Top center
                radius: 1.4,
                colors: [
                  Color(0x0e6366f1), // Indigo with 5.5% opacity
                  Color(0x00f8fafc), // Fade to transparent Slate-50
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        // Fine technical grid
        const Positioned.fill(
          child: RepaintBoundary(
            child: GridPattern(),
          ),
        ),
        // Child content
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

class GridPattern extends StatelessWidget {
  const GridPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.015) // Subtle dark grid lines
      ..strokeWidth = 1.0;

    const double gridSpacing = 48.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => false;
}
