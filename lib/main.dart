import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import 'presentation/screens/home/home_page.dart';
import 'presentation/screens/privacy_policy/privacy_policy_page.dart';

/// Entry point for the Almotalem Website Flutter application.
void main() {
  usePathUrlStrategy();
  runApp(const AlmotalemWebsite());
}

/// Application-wide router configuration.
final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
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
  return MaterialApp(
    title: 'Al Motalem',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Page not found',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Root widget of the application.
class AlmotalemWebsite extends StatelessWidget {
  const AlmotalemWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'Al Motalem',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              surface: const Color(0xFF18181B),
            ),
          ),
        );
      },
    );
  }
}
