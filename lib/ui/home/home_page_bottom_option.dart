import 'package:flutter/material.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class HomePageBottomOption extends StatelessWidget {
  const HomePageBottomOption({
    Key? key,
    required this.onFlip,
  }) : super(key: key);
  final VoidCallback onFlip;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onFlip,
          icon: const Icon(
            Icons.flip,
          ),
          color: AppTheme.of(context).settingsLabel,
        ),
      ],
    );
  }
}
