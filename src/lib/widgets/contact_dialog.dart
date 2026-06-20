import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({super.key});

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  bool _isCopied = false;

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'apps@ideaspaceapps.store',
      queryParameters: {
        'subject': 'IdeaSpace Support Request',
      },
    );
    
    if (await launchUrl(emailLaunchUri)) {
      if (mounted) Navigator.of(context).pop();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch default email application.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(const ClipboardData(text: 'apps@ideaspaceapps.store')).then((_) {
      setState(() {
        _isCopied = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95), // White with opacity
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get in Touch',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff0f172a), // Slate-900
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Color(0xff475569)), // Slate-600
                    hoverColor: Colors.black.withValues(alpha: 0.05),
                    splashRadius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Description
              Text(
                'Have questions, feedback, or need support with any of our applications? We are here to help.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: const Color(0xff475569), // Slate-600
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // Contact Email Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff4f4f5), // Zinc-100
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.mail_outline_rounded,
                      color: Color(0xff6366f1), // Indigo accent
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Support Email',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xff71717a), // Zinc-500
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          SelectableText(
                            'apps@ideaspaceapps.store',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              color: const Color(0xff0f172a), // Slate-900
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Copy button
                    IconButton(
                      tooltip: 'Copy to clipboard',
                      onPressed: _copyToClipboard,
                      icon: Icon(
                        _isCopied ? Icons.check_circle_outline : Icons.copy_rounded,
                        color: _isCopied ? const Color(0xff10b981) : const Color(0xff475569), // Slate-600
                        size: 20,
                      ),
                      hoverColor: Colors.black.withValues(alpha: 0.05),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.black.withValues(alpha: 0.15)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.outfit(
                          color: const Color(0xff475569), // Slate-600
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff6366f1), Color(0xff4f46e5)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: _sendEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Send Email',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Notice
              Text(
                'We typically respond to support inquiries within 24 to 48 hours.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: const Color(0xff71717a), // Zinc-500
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
