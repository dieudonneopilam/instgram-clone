import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation(
      {super.key,
      required this.child,
      required this.isAnimation,
      this.duration = const Duration(milliseconds: 150),
      this.smallike = false,
      this.onEnd});
  final Widget child;
  final bool isAnimation;
  final Duration duration;
  final bool smallike;
  final VoidCallback? onEnd;

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds));
    scale = Tween<double>(begin: 1, end: 1.2).animate(animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    if (widget.isAnimation != oldWidget.isAnimation) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  startAnimation() async {
    if (widget.isAnimation || widget.smallike) {
      await animationController.forward();
      await animationController.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
