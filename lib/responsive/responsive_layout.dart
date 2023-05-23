import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:gde/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.WebScreenLayout,
      required this.MobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        if (BoxConstraints.minWidth > webScreen) {
          return WebScreenLayout;
        }
        return MobileScreenLayout;
      },
    );
  }
}
