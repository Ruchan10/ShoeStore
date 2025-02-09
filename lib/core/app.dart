import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store_app/config/router/app_route.dart';

import '../config/themes/app_theme.dart';
import 'common/provider/is_dark_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Store',
      theme: AppTheme.getApplicationTheme(isDarkTheme),
      initialRoute: AppRoute.homeRoute,
      routes: AppRoute.getAppRoutes(),
    );
  }
}
