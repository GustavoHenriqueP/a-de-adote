import 'package:flutter/material.dart';
import '../style/project_colors.dart';
import '../style/project_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final Function()? route;

  const AnimatedButton({super.key, required this.route});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..forward();
  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(1.5, 0),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ),
  );

  void initAnimation() async {
    await _controller.animateTo(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initAnimation;
    return SlideTransition(
      position: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.5),
        decoration: const BoxDecoration(
          color: ProjectColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          hoverColor: ProjectColors.primaryDark,
          onTap: widget.route,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'VAMOS COMEÇAR',
                style: ProjectFonts.pLightBold,
              )
            ],
          ),
        ),
      ),
    );
  }
}