import 'package:flutter/material.dart';
import 'package:habit_tracking_app/constants/app_assets.dart';
import 'package:habit_tracking_app/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracking_app/ui/tasks/task_completion_ring.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({
    Key? key,
    required this.iconName,
  }) : super(key: key);
  final String iconName;
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> curveAnimation;
  bool showCheckIcon = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 750,
      ),
    );
    curveAnimation = animationController.drive(
      CurveTween(
        curve: Curves.easeOut,
      ),
    );
    animationController.addStatusListener(checkStatusUpdates);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(checkStatusUpdates);
    animationController.dispose();
    super.dispose();
  }

//task buton pressed
  handleTapDown(TapDownDetails details) {
    if (animationController.status != AnimationStatus.completed) {
      animationController.forward();
    } else if(!showCheckIcon){
      animationController.value = 0.0;
    }
  }

//task button cancel or relesed
  handleTapCancel() {
    if (animationController.status != AnimationStatus.completed) {
      animationController.reverse();
    }
  }

//task status completed
  checkStatusUpdates(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if(mounted)
     {
        setState(() {
          showCheckIcon = true;
        });
      }
      Future.delayed(const Duration(seconds: 1 ), () {
        if(mounted){
          setState(() {
            showCheckIcon = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: handleTapDown,
      onTapUp:(_)=> handleTapCancel(),
      onTapCancel: handleTapCancel,
      child: AnimatedBuilder(
          animation: curveAnimation,
          builder: (BuildContext context, Widget? child) {
            final themeData = AppTheme.of(context);
            final progress = curveAnimation.value;
            final hasCompleted = progress == 1.0;
            final iconColor =
                hasCompleted ? themeData.accentNegative : themeData.taskIcon;
            return Stack(
              children: [
                TaskCompletionRing(
                  progress: progress,
                ),
                Positioned.fill(
                  child: CenteredSvgIcon(
                    iconName: hasCompleted && showCheckIcon
                        ? AppAssets.check
                        : widget.iconName,
                    color: iconColor,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
