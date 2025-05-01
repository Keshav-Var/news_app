import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/di.dart' as di;
import 'package:news_app/features/news/presentation/providers/detail_screen_provider.dart';
import 'package:news_app/features/news/presentation/providers/home_screen_provider.dart';
import 'package:news_app/features/news/presentation/providers/saved_news_screen_provider.dart';
import 'package:news_app/features/splash/presentation/providers/splash_provider.dart';
import 'package:news_app/routes.dart';
import 'package:news_app/skeleton/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, _, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<SavedNewsScreenProvider>(
              create: (_) => di.sl<SavedNewsScreenProvider>(),
            ),
            ChangeNotifierProvider<DetailScreenProvider>(
              create: (_) => di.sl<DetailScreenProvider>(),
            ),
            ChangeNotifierProvider<SplashProvider>(
              create: (_) => di.sl<SplashProvider>(),
            ),
            ChangeNotifierProvider(
              create: (_) => di.sl<BottomNavigationProvider>(),
            ),
            ChangeNotifierProvider(create: (_) => di.sl<HomeScreenProvider>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: AppRoutes.approutes,
          ),
        );
      },
    );
  }
}
