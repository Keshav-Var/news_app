import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/presentation/pages/detail_screen.dart';
import 'package:news_app/features/news/presentation/pages/home_screen.dart';
import 'package:news_app/features/news/presentation/pages/saved_news_screen.dart';
import 'package:news_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:news_app/skeleton/skeleton.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRoutes {
  static final approutes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/",

    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => Skeleton(child: child),
        routes: <RouteBase>[
          GoRoute(
            name: "home",
            path: "/home",
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            name: "saved_news",
            path: "/saved_news",
            builder: (context, state) => SavedNewsScreen(),
          ),
        ],
      ),
      GoRoute(
        name: "detail",
        path: "/detail",
        builder:
            (context, state) => DetailScreen(news: state.extra as NewsEntity),
      ),
      GoRoute(
        name: "splash",
        path: "/",
        builder: (context, state) => SplashScreen(),
      ),
    ],
  );
}
