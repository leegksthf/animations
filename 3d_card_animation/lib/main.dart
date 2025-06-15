import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhysicsCardDragDemo(),
    ),
  );
}

class PhysicsCardDragDemo extends StatefulWidget {
  const PhysicsCardDragDemo({super.key});

  @override
  State<PhysicsCardDragDemo> createState() => _PhysicsCardDragDemoState();
}

class _PhysicsCardDragDemoState extends State<PhysicsCardDragDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool isClicked = false;

  late final colorAnimation = ColorTween(
    begin: Colors.white,
    end: Colors.grey[900],
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: colorAnimation.value,
          body: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                  if (isClicked) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
              child: Stack(
                children:
                    [
                      TextLayerWidget(
                        isClicked: isClicked,
                        animation: animation,
                      ),
                      PaddingLayerWidget(
                        isClicked: isClicked,
                        animation: animation,
                      ),
                      BorderLayerWidget(
                        isClicked: isClicked,
                        animation: animation,
                      ),
                      BaseLayerWidget(
                        isClicked: isClicked,
                        animation: animation,
                      ),
                      ShadowLayerWidget(
                        isClicked: isClicked,
                        animation: animation,
                      ),
                    ].reversed.toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TransformLayer extends StatelessWidget {
  const TransformLayer({
    super.key,
    this.translateOffset = Offset.zero,
    required this.child,
    required this.isClicked,
    required this.animation,
  });

  final Widget child;
  final Offset translateOffset;
  final bool isClicked;
  final Animation<double> animation;

  // 각도를 라디안으로 변환
  double degreeToRadian({required double degree}) {
    return degree * (pi / 180);
  }

  // 기준점에서 특정 각도 + 거리(distance) 만큼 떨어진 곳의 좌표를 구함
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder:
          (context, _) => Transform.translate(
            offset: Offset(
              translateOffset.dx,
              animation.value * translateOffset.dy,
            ),
            child: Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..rotateX(degreeToRadian(degree: animation.value * 50))
                    ..rotateZ(degreeToRadian(degree: animation.value * 50)),
              child: child,
            ),
          ),
    );
  }
}

class TextLayerWidget extends StatelessWidget {
  const TextLayerWidget({
    super.key,
    required this.isClicked,
    required this.animation,
  });

  final bool isClicked;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 250.0;

    return AnimatedBuilder(
      animation: animation,
      builder:
          (context, child) => TransformLayer(
            animation: animation,
            translateOffset: Offset(0, -200),
            isClicked: isClicked,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(20),
              child: AnimatedDefaultTextStyle(
                curve: isClicked ? Curves.easeOutExpo : Curves.easeInExpo,
                duration: const Duration(seconds: 1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      isClicked
                          ? Colors.white
                          : Colors.black.withValues(alpha: 0.8),
                ),
                child: Text('3D Layered Card \n @hansol'),
              ),
            ),
          ),
    );
  }
}

class PaddingLayerWidget extends StatelessWidget {
  const PaddingLayerWidget({
    super.key,
    required this.isClicked,
    required this.animation,
  });

  final bool isClicked;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 250.0;

    return TransformLayer(
      animation: animation,
      isClicked: isClicked,
      translateOffset: Offset(0, -100),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.blue.withValues(alpha: animation.value * 0.5),
          BlendMode.srcIn,
        ),
        child: CustomPaint(painter: LinePainter(), size: Size(width, height)),
      ),
    );
  }
}

class BorderLayerWidget extends StatelessWidget {
  const BorderLayerWidget({
    super.key,
    required this.isClicked,
    required this.animation,
  });

  final bool isClicked;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 250.0;

    return TransformLayer(
      animation: animation,
      isClicked: isClicked,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink, width: 2),
        ),
      ),
    );
  }
}

class BaseLayerWidget extends StatelessWidget {
  const BaseLayerWidget({
    super.key,
    required this.isClicked,
    required this.animation,
  });

  final bool isClicked;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 250.0;

    return TransformLayer(
      animation: animation,
      isClicked: isClicked,
      translateOffset: Offset(0, 100),
      child: Container(width: width, height: height, color: Colors.grey[200]),
    );
  }
}

class ShadowLayerWidget extends StatelessWidget {
  const ShadowLayerWidget({
    super.key,
    required this.isClicked,
    required this.animation,
  });

  final bool isClicked;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 250.0;

    return TransformLayer(
      animation: animation,
      isClicked: isClicked,
      translateOffset: Offset(0, 200),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 20,
              color: Colors.grey.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = Colors.blue;

    // 라인 그리기
    // canvas.drawLine(
    //   Offset(size.width / 6, size.height / 2),
    //   Offset(size.width * 5 / 6, size.height / 2),
    //   paint,
    // );

    for (int i = 0; i < 80; i++) {
      if (i.isOdd) {
        if (i < 40) {
          canvas.drawLine(
            Offset((size.width / 40) * (i), 0),
            Offset(0, (size.height / 40) * (i)),
            paint,
          );
        } else {
          canvas.drawLine(
            Offset(size.width, (size.height / 40) * (i - 40)),
            Offset((size.width / 40) * (i - 40), size.height),
            paint,
          );
        }
      }
    }

    // 사각형 그리기
    final a = Offset(20, 20);
    final b = Offset(230, 230);
    // final a = Offset(size.width / 6, size.height / 4);
    // final b = Offset(size.width * 5 / 6, size.height * 3 / 4);
    final rect = Rect.fromPoints(a, b);
    // final rrect = RRect.fromRectAndRadius(rect, Radius.circular(10));
    // canvas.drawRRect(rrect, paint);

    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    paint.blendMode = BlendMode.clear;
    canvas.drawRect(rect, paint);

    // canvas.drawPoints(PointMode.lines, [a, b], paint);

    // 원형 그리기
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
