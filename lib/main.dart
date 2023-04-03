import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BouncingBall());
  }
}

class BouncingBall extends StatefulWidget {
  const BouncingBall({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BouncingBallState createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  final double _ballSize = 50;
  double _x = 0;
  double _y = 0;
  double _dx = 3;
  double _dy = 5;
  late double _screenWidth;
  late double _screenHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
        setState(() {
          _x += _dx;
          _y += _dy;
          if (_x < 0 || _x > _screenWidth - _ballSize) {
            _dx *= -1;
          }
          if (_y < 0 || _y > _screenHeight - _ballSize) {
            _dy *= -1;
          }
        });
      });

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 1.0),
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Transform.translate(
        offset: Offset(
          _x + _positionAnimation.value.dx,
          _y + _positionAnimation.value.dy,
        ),
        child: Container(
          width: _ballSize,
          height: _ballSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
