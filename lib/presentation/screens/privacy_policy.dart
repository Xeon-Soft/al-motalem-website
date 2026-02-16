import 'package:almotalem_website/core/services/privacy_policy_service.dart';
import 'package:almotalem_website/presentation/components/common/background_grid_motion.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sizer/sizer.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String? _content;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPrivacyPolicy();
  }

  Future<void> _loadPrivacyPolicy() async {
    try {
      final content = await PrivacyPolicyService.fetchPrivacyPolicy();
      setState(() {
        _content = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: RetroGridBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 32,
            children: [
              Image.asset('assets/images/icon.png', width: 100, height: 100),
              Text('Privacy Policy').x3Large.bold,
              Container(
                height: 40.h,
                width: 80.w,
                padding: EdgeInsets.all(24.px),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildBody(),
              ),
              PrimaryButton(
                child: Text('Return to home page'),
                onPressed: () {
                  context.go('/');
                },
              ),
              Text('© 2026 XEONSOFT. All rights reserved.').xSmall.muted,
            ],
          ).withPadding(vertical: 24),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
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

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Failed to load privacy policy').x2Large,
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
              // Handle link taps
              debugPrint('Link tapped: $url');
            },
          ),
        ],
      ),
    );
  }
}
