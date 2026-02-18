import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sizer/sizer.dart';

import 'presentation/screens/home/home_page.dart';
import 'presentation/screens/privacy_policy/privacy_policy_page.dart';

/// Entry point for the Almotalem Website Flutter application.
/// 
/// This is a web-only Flutter application that uses:
/// - [go_router] for navigation
/// - [shadcn_flutter] for UI components
/// - [sizer] for responsive layouts
/// - Path-based URL strategy for clean URLs
void main() {
  // Use path-based URL strategy instead of hash-based URLs
  // This creates cleaner URLs like /privacy-policy instead of /#/privacy-policy
  usePathUrlStrategy();

  runApp(const AlmotalemWebsite());
}

/// Application-wide router configuration.
/// 
/// Defines all available routes and their corresponding screens.
/// Includes a custom 404 error page for unknown routes.
final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // Enable for development, disable in production
  errorBuilder: (context, state) => _buildErrorPage(context),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
  ],
);

/// Builds a 404 error page for unknown routes.
Widget _buildErrorPage(BuildContext context) {
  return ShadcnApp(
    title: 'Al Motalem',
    theme: ThemeData(colorScheme: ColorSchemes.darkZinc),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 35,
          children: [
            const Text('404').x4Large.bold,
            const Text('Page not found').large.muted,
          ],
        ),
      ),
    ),
  );
}

/// Root widget of the application.
/// 
/// Wraps the app with [Sizer] for responsive layouts and [ShadcnApp.router]
/// for routing and theming.
class AlmotalemWebsite extends StatelessWidget {
  /// Creates the root widget.
  const AlmotalemWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ShadcnApp.router(
          routerConfig: router,
          title: 'Al Motalem',
          theme: ThemeData(
            colorScheme: ColorSchemes.darkZinc,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
