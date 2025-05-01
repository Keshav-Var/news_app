import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/splash/presentation/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    await Future.delayed(Duration(seconds: 5));
    await splashProvider.checkConnection();

    if (!mounted) return;

    switch (splashProvider.status) {
      case SplashStatus.online:
        context.go('/home');
        break;
      case SplashStatus.offline:
        context.go('/saved_news');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SizedBox(
          height: 30.w,
          width: 30.h,
          child: Image.asset("assets/images/icon.png", height: 200, width: 200),
        ),
      ),
    );
  }
}
