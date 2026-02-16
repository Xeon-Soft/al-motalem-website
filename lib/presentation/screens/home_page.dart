import 'package:almotalem_website/presentation/components/common/background_grid_motion.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildToast(BuildContext context, ToastOverlay overlay) {
    return SurfaceCard(
      child: Basic(
        title: const Text('This application is still under development.'),
        subtitle: const Text(
          'You can visit this site later to download the app.',
        ),
        trailing: PrimaryButton(
          size: ButtonSize.small,
          onPressed: () {
            // Close the toast programmatically when clicking Undo.
            overlay.close();
          },
          child: const Text('Okay'),
        ),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: RetroGridBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 32,
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    width: 150,
                    height: 150,
                  ),
                  Text('Al Motalem App').x4Large.bold,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [
                      PrimaryButton(
                        onPressed: () {
                          showToast(
                            context: context,
                            builder: buildToast,
                            location: ToastLocation.bottomRight,
                          );
                        },
                        child: Text('Download App'),
                      ),
                      OutlineButton(
                        onPressed: () {
                          context.replace('/privacy-policy');
                        },
                        child: Text('Privacy Policy'),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
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
                        colorFilter: ColorFilter.mode(
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
                  SizedBox(),
                  Text('© 2026 XEONSOFT. All rights reserved.').xSmall.muted,
                ],
              ),
            ],
          ).withPadding(vertical: 24),
        ),
      ),
    );
  }
}
