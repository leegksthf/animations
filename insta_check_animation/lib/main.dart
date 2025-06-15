import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    controller.forward().whenComplete(() async {
      await Future.delayed(Duration(seconds: 2), () {
        controller.forward();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SizedBox(
          width: 150,
          height: 150,
          child: AnimatedBuilder(
            animation: controller,
            builder:
                (context, child) => CustomPaint(
                  painter: CompletePainter(
                    animationValue: controller.value,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class CompletePainter extends CustomPainter {
  const CompletePainter({
    required this.animationValue,
    required this.width,
    required this.height,
  });

  final double animationValue;
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    final firstValue = Interval(0, 0.5).transform(animationValue);
    final secondValue = Interval(0.5, 0.75).transform(animationValue);
    final thirdValue = Interval(0.75, 1).transform(animationValue);

    final circleOffset = Offset(width / 2, height / 2);
    final checkStartPoint = Offset(
      circleOffset.dx * 0.83,
      circleOffset.dy * 0.99,
    );
    final checkCenterPoint = Offset(
      checkStartPoint.dx + (circleOffset.dx * 0.12) * secondValue,
      checkStartPoint.dy + (circleOffset.dy * 0.05) * secondValue,
    );
    final checkEndPoint = Offset(
      checkCenterPoint.dx + (circleOffset.dx * 0.23) * thirdValue,
      checkCenterPoint.dy - (circleOffset.dy * 0.1) * thirdValue,
    );
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..shader = LinearGradient(
            colors: [Colors.yellow, Colors.red, Colors.pink],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ).createShader(
            Rect.fromCircle(center: circleOffset, radius: size.width / 2),
          )
          ..strokeWidth = 5 + max((1 - firstValue) * 20, 0);

    canvas.drawCircle(circleOffset, firstValue * (size.width / 2), paint);
    paint.strokeCap = StrokeCap.round;

    if (secondValue > 0) {
      canvas.drawLine(checkStartPoint, checkCenterPoint, paint);
    }

    if (thirdValue > 0) {
      canvas.drawLine(checkCenterPoint, checkEndPoint, paint);
    }
    ;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
