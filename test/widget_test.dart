/// Widget tests for the Almotalem website.
/// 
/// Note: These tests run in the Dart VM, so web-specific code (like flutter_web_plugins)
/// is not available. We test individual widgets in isolation.
library;

import 'package:almotalem_website/presentation/components/common/animated_background.dart';
import 'package:almotalem_website/presentation/screens/home/home_page.dart';
import 'package:almotalem_website/presentation/screens/privacy_policy/privacy_policy_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sizer/sizer.dart';

/// Wraps a widget with required ancestors for testing.
Widget _buildTestableWidget(Widget child) {
  return Sizer(
    builder: (context, orientation, deviceType) {
      return ShadcnApp(
        home: child,
      );
    },
  );
}

void main() {
  group('HomePage', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      // Use pump instead of pumpAndSettle because AnimatedBackground has infinite animation
      await tester.pump();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('should display app title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      await tester.pump();

      expect(find.text('Al Motalem App'), findsOneWidget);
    });

    testWidgets('should display download button', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      await tester.pump();

      expect(find.text('Download App'), findsOneWidget);
    });

    testWidgets('should display privacy policy button', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      await tester.pump();

      expect(find.text('Privacy Policy'), findsOneWidget);
    });

    testWidgets('should display copyright', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      await tester.pump();

      expect(find.text('© 2026 XEONSOFT. All rights reserved.'), findsOneWidget);
    });

    testWidgets('should have animated background', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const HomePage()));
      await tester.pump();

      expect(find.byType(AnimatedBackground), findsOneWidget);
    });
  });

  group('PrivacyPolicyPage', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const PrivacyPolicyPage()));
      await tester.pump();

      expect(find.byType(PrivacyPolicyPage), findsOneWidget);
    });

    testWidgets('should display page title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const PrivacyPolicyPage()));
      await tester.pump();

      expect(find.text('Privacy Policy'), findsOneWidget);
    });

    testWidgets('should display return button', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const PrivacyPolicyPage()));
      await tester.pump();

      expect(find.text('Return to home page'), findsOneWidget);
    });

    testWidgets('should display loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableWidget(const PrivacyPolicyPage()));
      
      // Should show loading indicator before data loads
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading privacy policy...'), findsOneWidget);
    });
  });

  group('AnimatedBackground', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(
          const AnimatedBackground(
            child: Text('Test Content'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AnimatedBackground), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should render without child', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestableWidget(const AnimatedBackground()),
      );
      await tester.pump();

      expect(find.byType(AnimatedBackground), findsOneWidget);
    });
  });
}
