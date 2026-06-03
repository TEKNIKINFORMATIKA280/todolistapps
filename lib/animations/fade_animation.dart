import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: Duration(milliseconds: (500 * delay).round()))
        .fadeIn(duration: 500.ms);
  }
}
