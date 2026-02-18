import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Animated background widget featuring a retro-style grid with perspective.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({
    super.key,
    this.angle = 65,
    this.child,
  });

  final double angle;
  final Widget? child;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gridAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _gridAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _gridAnimation,
                    builder: (context, child) => Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.004)
                        ..rotateX(-30 * math.pi / 180)
                        // ignore: deprecated_member_use
                        ..scale(2.0, 2.0, 2.0),
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        size: size,
                        painter: _GridPainter(
                          offset: _gridAnimation.value,
                          isDark: isDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.transparent,
                        isDark
                            ? const Color(0xF2000000)
                            : const Color(0xF2FFFFFF),
                      ],
                      stops: const [0.6, 0.8],
                    ),
                  ),
                ),
              ),
              if (widget.child != null)
                Center(
                  child: widget.child,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.offset,
    required this.isDark,
  });

  final double offset;
  final bool isDark;
  static const double _gridSize = 40.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? const Color(0x4DFFFFFF)
          : const Color(0x66000000)
      ..strokeWidth = 1.5;

    final verticalLines = (size.width / _gridSize).ceil() + 1;
    final horizontalLines = (size.height / _gridSize).ceil() + 1;

    for (var i = 0; i < verticalLines; i++) {
      final x = i * _gridSize;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    final animationOffset = offset * _gridSize * 2;
    for (var i = 0; i < horizontalLines; i++) {
      final y = (i * _gridSize) - animationOffset;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) {
    return offset != oldDelegate.offset || isDark != oldDelegate.isDark;
  }
}
