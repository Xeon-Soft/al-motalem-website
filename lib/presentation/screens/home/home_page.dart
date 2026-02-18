import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../components/common/animated_background.dart';

/// Home page of the Almotalem website.
/// 
/// Displays the main landing page with app branding, download button,
/// and links to other pages.
class HomePage extends StatelessWidget {
  /// Creates the home page.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: AnimatedBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              _buildMainContent(context),
              _buildFooter(context),
            ],
          ).withPadding(vertical: 24),
        ),
      ),
    );
  }

  /// Builds the main content section with app icon, title, and action buttons.
  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        // App icon
        Image.asset(
          'assets/images/icon.png',
          width: 150,
          height: 150,
        ),
        
        // App title
        const Text('Al Motalem App').x4Large.bold,
        
        // Action buttons
        _buildActionButtons(context),
      ],
    );
  }

  /// Builds the action buttons (Download and Privacy Policy).
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        PrimaryButton(
          onPressed: () => _showComingSoonToast(context),
          child: const Text('Download App'),
        ),
        OutlineButton(
          onPressed: () => context.go('/privacy-policy'),
          child: const Text('Privacy Policy'),
        ),
      ],
    );
  }

  /// Shows a toast notification indicating the app is under development.
  void _showComingSoonToast(BuildContext context) {
    showToast(
      context: context,
      builder: (context, overlay) => SurfaceCard(
        child: Basic(
          title: const Text('This application is still under development.'),
          subtitle: const Text(
            'You can visit this site later to download the app.',
          ),
          trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: overlay.close,
            child: const Text('Okay'),
          ),
          trailingAlignment: Alignment.center,
        ),
      ),
      location: ToastLocation.bottomRight,
    );
  }

  /// Builds the footer section with logos and copyright.
  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 36,
          children: [
            Image.asset(
              'assets/images/logo_with_text_dark.png',
              width: 100,
            ),
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
        const SizedBox.shrink(),
        const Text('© 2026 XEONSOFT. All rights reserved.').xSmall.muted,
      ],
    );
  }
}
