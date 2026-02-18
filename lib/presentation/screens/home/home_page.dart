import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/common/animated_background.dart';

/// Home page of the Almotalem website.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              _buildMainContent(context),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/icon.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 32),
        const Text(
          'Al Motalem App',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => _showComingSoonDialog(context),
          child: const Text('Download App'),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: () => context.go('/privacy-policy'),
          child: const Text('Privacy Policy'),
        ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text(
          'This application is still under development. You can visit this site later to download the app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_with_text_dark.png',
              width: 100,
            ),
            const SizedBox(width: 36),
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/almotalem-splash-text.png',
                width: 100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          '© 2026 XEONSOFT. All rights reserved.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
