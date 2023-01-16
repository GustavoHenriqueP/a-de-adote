import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitalAnimation extends StatefulWidget {
  const InitalAnimation({super.key});

  @override
  State<InitalAnimation> createState() => _InitalAnimationState();
}

class _InitalAnimationState extends State<InitalAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(seconds: 4);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Lottie.asset(
        'assets/lottie/initial_animation.json',
        controller: _controller,
      ),
    );
  }
}
