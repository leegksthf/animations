import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Center(
          child: ClipPath(
            clipper: LightningClipper(),
            child: Container(width: 250, height: 330, color: Colors.amber),
          ),
        ),
      ),
    );
  }
}

class LightningClipper extends CustomClipper<Path> {
  Offset getOffsetAlongLine(Offset from, Offset to, double distance) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final length = sqrt(dx * dx + dy * dy);
    final scale = distance / length;
    return Offset(from.dx + dx * scale, from.dy + dy * scale);
  }

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();
    final yWeight = 0.12;
    final radius = 10.0;
    final points = [
      Offset(w / 2, 0),
      Offset(w / 2 - 10, h * (0.5 - yWeight)),
      Offset(w, h * (0.5 - yWeight) - 10),
      Offset(w / 2, h),
      Offset(w / 2 + 10, h * (0.5 + yWeight) - 10),
      Offset(0, h * (0.5 + yWeight)),
    ];

    for (int i = 0; i < points.length; i++) {
      final prev = points[(i - 1 + points.length) % points.length];
      final current = points[i];
      final next = points[(i + 1) % points.length];

      final p1 = getOffsetAlongLine(current, prev, radius);
      final p2 = getOffsetAlongLine(current, next, radius);

      if (i == 0) {
        path.moveTo(p1.dx, p1.dy);
      } else {
        path.lineTo(p1.dx, p1.dy);
      }

      path.quadraticBezierTo(current.dx, current.dy, p2.dx, p2.dy);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
