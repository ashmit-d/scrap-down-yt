import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;

  const AnimatedBackground({
    super.key,
    required this.child,
    required this.colors,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> _animatedColors(double value) {
    return widget.colors.map((color) {
      final r = (color.red + sin(value) * 20).clamp(0, 255).toInt();
      final g = (color.green + cos(value) * 20).clamp(0, 255).toInt();
      final b = (color.blue + sin(value / 2) * 20).clamp(0, 255).toInt();
      return Color.fromRGBO(r, g, b, 1);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _animatedColors(_animation.value),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
