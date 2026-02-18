import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/privacy_policy_service.dart';
import '../../components/common/animated_background.dart';

/// Privacy Policy page displaying the app's privacy policy content.
/// 
/// Fetches and displays markdown content from the privacy policy API.
/// Includes loading states, error handling, and retry functionality.
class PrivacyPolicyPage extends StatefulWidget {
  /// Creates the privacy policy page.
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String? _content;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPrivacyPolicy();
  }

  /// Loads privacy policy content from the API.
  Future<void> _loadPrivacyPolicy() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final content = await PrivacyPolicyService.fetchPrivacyPolicy();
      if (mounted) {
        setState(() {
          _content = content;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: AnimatedBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 32,
            children: [
              // App icon
              Image.asset(
                'assets/images/icon.png',
                width: 100,
                height: 100,
              ),
              
              // Page title
              const Text('Privacy Policy').x3Large.bold,
              
              // Content card
              _buildContentCard(context),
              
              // Return button
              PrimaryButton(
                onPressed: () => context.go('/'),
                child: const Text('Return to home page'),
              ),
              
              // Copyright
              const Text('© 2026 XEONSOFT. All rights reserved.').xSmall.muted,
            ],
          ).withPadding(vertical: 24),
        ),
      ),
    );
  }

  /// Builds the content card with loading, error, or content states.
  Widget _buildContentCard(BuildContext context) {
    return Container(
      height: 40.h,
      width: 80.w,
      padding: EdgeInsets.all(24.px),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildBody(),
    );
  }

  /// Builds the body content based on current state.
  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_error != null) {
      return _buildErrorState();
    }

    return _buildMarkdownContent();
  }

  /// Builds the loading state widget.
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CircularProgressIndicator(),
          Text('Loading privacy policy...'),
        ],
      ),
    );
  }

  /// Builds the error state widget with retry functionality.
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Failed to load privacy policy').x2Large,
            const SizedBox(height: 8),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.gray[600]),
            ),
            const SizedBox(height: 24),
            IconButton.outline(
              onPressed: _loadPrivacyPolicy,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the markdown content widget.
  Widget _buildMarkdownContent() {
    return MarkdownWidget(
      data: _content!,
      config: MarkdownConfig(
        configs: [
          H1Config(
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          H2Config(
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          PConfig(
            textStyle: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white,
            ),
          ),
          LinkConfig(
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onTap: (url) {
              debugPrint('Link tapped: $url');
            },
          ),
        ],
      ),
    );
  }
}
