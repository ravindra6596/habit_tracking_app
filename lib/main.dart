import 'package:flutter/material.dart';
import 'package:habit_tracking_app/constants/app_colors.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

import 'constants/app_assets.dart';
import 'ui/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
          data: AppThemeData.defaultWithSwatch(
            AppColors.red,
          ),
          child: const HomePage()),
    );
  }
}
