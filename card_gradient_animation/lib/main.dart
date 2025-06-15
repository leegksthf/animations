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
  late Animation<double> _xGradientAlignmentAnimation;
  late Animation<double> _yGradientAlignmentAnimation;
  late Animation<double> _yRotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          Future.delayed(Duration(milliseconds: 500), () {
            _controller.reverse().then((value) {
              Future.delayed(Duration(milliseconds: 500), () {
                _controller.forward();
              });
            });
          });
        }
      }
    });

    _xGradientAlignmentAnimation = Tween<double>(
      begin: -1,
      end: 1,
    ).animate(_controller);
    _yGradientAlignmentAnimation = Tween<double>(
      begin: -0.4,
      end: 0.4,
    ).animate(_controller);

    _yRotateAnimation = Tween<double>(begin: 0, end: 0.2).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = 250;
    final cardHeight = 400;
    final borderRadius = Radius.circular(5);
    final cardIcColor = const Color(0xFFF9F1DC);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Stack(
            children: [
              Transform.rotate(
                angle: -0.2,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(_yRotateAnimation.value),
                      child: Stack(
                        children: [
                          Container(
                            width: 250,
                            height: 400,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                radius: 1.1,
                                center: Alignment(
                                  _xGradientAlignmentAnimation.value,
                                  _yGradientAlignmentAnimation.value,
                                ),
                                colors: [
                                  Colors.white,
                                  const Color.fromARGB(255, 249, 229, 229),
                                  const Color.fromARGB(255, 237, 164, 164),
                                  const Color.fromARGB(255, 252, 73, 73),
                                ],
                                stops: const [0, 0.3, 0.7, 1],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Positioned(
                            left: cardWidth * 4 / 7,
                            top: cardHeight * 1 / 9,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: borderRadius,
                                      bottomLeft: borderRadius,
                                    ),
                                    color: cardIcColor,
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Container(
                                  width: 8,
                                  height: 40,
                                  color: cardIcColor,
                                ),
                                const SizedBox(width: 1),
                                Container(
                                  width: 8,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: borderRadius,
                                      bottomRight: borderRadius,
                                    ),
                                    color: cardIcColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              '@hansol',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
