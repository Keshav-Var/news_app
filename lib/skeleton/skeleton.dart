import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/skeleton/bottom_navigation_provider.dart';
import 'package:news_app/skeleton/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class Skeleton extends StatefulWidget {
  final Widget child;
  const Skeleton({super.key, required this.child});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Defer the update until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = GoRouterState.of(context).uri.toString();
      Provider.of<BottomNavigationProvider>(
        context,
        listen: false,
      ).setSelectedIndexByRoute(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
