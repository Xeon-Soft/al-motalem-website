import 'package:almotalem_website/presentation/screens/home_page.dart';
import 'package:almotalem_website/presentation/screens/privacy_policy.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sizer/sizer.dart';

void main() {
  usePathUrlStrategy();

  runApp(const AlmotalemWebsite());
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => ShadcnApp(
    title: 'Al Motalem',
    theme: ThemeData(colorScheme: ColorSchemes.darkZinc),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 35,
          children: [
            Text('404').x4Large.bold,
            Text('Page not found').large.muted,
          ],
        ),
      ),
    ),
  ),
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => PrivacyPolicy(),
    ),
  ],
);

class AlmotalemWebsite extends StatelessWidget {
  const AlmotalemWebsite({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ShadcnApp.router(
          routerConfig: router,
          title: 'Al Motalem',
          theme: ThemeData(colorScheme: ColorSchemes.darkZinc),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
