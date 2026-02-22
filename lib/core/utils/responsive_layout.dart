import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget? tabletLayout;
  final Widget? webLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    this.tabletLayout,
    this.webLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return mobileLayout;
        } else if (width < 1200) {
          return tabletLayout ?? webLayout ?? mobileLayout;
        } else {
          return webLayout ?? tabletLayout ?? mobileLayout;
        }
      },
    );
  }
}
