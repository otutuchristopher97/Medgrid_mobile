import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medgrid_app/core/components/texts/custom_text.dart';
import 'package:medgrid_app/core/pallet.dart';
import 'package:medgrid_app/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () async {
      context.pushReplacement(RouteConstants.drugScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallet.white,
      body: Center(
          child: CustomText(
            text: "MedGrid",
            size: 28,
            weight: FontWeight.w700,
            color: Pallet.primary,
          )),
    );
  }
}