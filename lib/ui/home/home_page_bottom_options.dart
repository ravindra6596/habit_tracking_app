import 'package:flutter/material.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class HomePageBottomOptions extends StatelessWidget {
  const HomePageBottomOptions({
    Key? key,
    this.onFlip,
    this.onEnterEditMode,
  }) : super(key: key);
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onEnterEditMode,
          icon: Icon(
            Icons.settings,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        // invisible
        Opacity(
          opacity: 0.0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ),
      ],
    );
  }
}
