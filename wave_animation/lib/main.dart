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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.all(50),

                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width / 2,
                    ),
                    ClipPath(
                      clipper: WaveClipper(animationValue: _controller.value),
                      child: CircleAvatar(
                        backgroundColor: const Color(
                          0xFF83C0F5,
                        ).withValues(alpha: 0.7),
                        radius: width / 2,
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper(
                        animationValue: _controller.value,
                        waveType: WaveType.cos,
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color(
                          0xFF3E94EF,
                        ).withValues(alpha: 0.7),
                        radius: width / 2,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

enum WaveType { sin, cos }

class WaveClipper extends CustomClipper<Path> {
  const WaveClipper({
    required this.animationValue,
    this.waveHeight,
    this.waveLength,
    this.waveType = WaveType.sin,
  });

  final double animationValue;
  final double? waveHeight;
  final double? waveLength;
  final WaveType waveType;

  @override
  Path getClip(Size size) {
    final path = Path();
    final waveHeight = this.waveHeight ?? 20;
    final waveLength = this.waveLength ?? size.width * 2;

    path.moveTo(0, size.height / 2);

    for (double i = 0; i <= size.width; i++) {
      final calcWave =
          waveType == WaveType.sin
              ? sin(2 * pi * ((i / waveLength) + animationValue))
              : cos(2 * pi * ((i / waveLength) + animationValue));
      final y = waveHeight * calcWave + size.height / 2;
      path.lineTo(i, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
