import 'package:flutter/material.dart';
import 'package:gde/responsive/mobileScreen.dart';
import 'package:gde/responsive/responsive_layout.dart';
import 'package:gde/responsive/webScreen.dart';
import 'package:gde/utils/dimension.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
          WebScreenLayout: WebScreenLayout(),
          MobileScreenLayout: MobileScreenLayout()),
    );
  }
}
