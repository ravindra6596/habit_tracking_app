import 'dart:math';

import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    Key? key,
    required this.frontBuilder,
    required this.backBuilder,
  }) : super(key: key);
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(microseconds: 500),
  );
  bool showFrontSize = true;

  @override
  void initState() {
    controller.addStatusListener(updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeStatusListener(updateStatus);
    controller.dispose();
    super.dispose();
  }

  void updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {
        showFrontSize = !showFrontSize;
      });
    }
  }

  void flip() {
    if (showFrontSize) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPageFlipBuilder(
      animation: controller,
      showFrontSize: showFrontSize,
      fronBuilder: widget.frontBuilder,
      backBuilder: widget.backBuilder,
    );
  }
}

class AnimatedPageFlipBuilder extends AnimatedWidget {
  const AnimatedPageFlipBuilder({
    Key? key,
    required Animation<double> animation,
    required this.backBuilder,
    required this.fronBuilder,
    required this.showFrontSize,
  }) : super(
          key: key,
          listenable: animation,
        );

  final bool showFrontSize;
  final WidgetBuilder fronBuilder;
  final WidgetBuilder backBuilder;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final isAnimationFirstHalf = animation.value < 0.5;
    final child =
        isAnimationFirstHalf ? fronBuilder(context) : backBuilder(context);
    final rotationValue = animation.value * pi;
    final rotationAngel =
        animation.value > 0.5 ? pi - rotationValue : rotationValue;
    var tilt = (animation.value - 0.5).abs() - 0.5;
    tilt *= isAnimationFirstHalf ? -0.003 : 0.003;
    return Transform(
      transform: Matrix4.rotationY(rotationAngel)
      ..setEntry(3, 0, tilt,),
      child: child,
      alignment: Alignment.center,
    );
  }
}
