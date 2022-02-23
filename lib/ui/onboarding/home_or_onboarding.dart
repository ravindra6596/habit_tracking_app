import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracking_app/persistence/hive_data_store.dart';
import 'package:habit_tracking_app/ui/home/home_page.dart';
import 'package:habit_tracking_app/ui/onboarding/onboarding_page.dart';
import 'package:hive/hive.dart';

class HomeOrOnboarding extends ConsumerWidget {
  const HomeOrOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.didAddFirstTaskListenable(),
      builder: (_, Box<bool> box, __) {
        return dataStore.didAddFirstTask(box) ? const HomePage() : const OnboardingPage();
      },
    );
  }
}
