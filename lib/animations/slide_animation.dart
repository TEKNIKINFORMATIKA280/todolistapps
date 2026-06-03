import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SlideAnimation extends StatelessWidget {
  final Widget child;
  final double delay;

  const SlideAnimation({super.key, required this.child, this.delay = 1.0});

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: Duration(milliseconds: (500 * delay).round()))
        .slideX(begin: 1.0, end: 0.0, duration: 500.ms);
  }
}
