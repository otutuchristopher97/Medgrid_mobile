import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medgrid_app/core/routing/routes.dart';
import 'package:medgrid_app/src/authentication/presentation/views/drug_screen.dart';
import 'package:medgrid_app/src/authentication/presentation/views/home_screen.dart';
import 'package:medgrid_app/src/authentication/presentation/views/qr_code_screen.dart';
import 'package:medgrid_app/src/authentication/presentation/views/splash_screen.dart';
import 'package:medgrid_app/src/authentication/presentation/views/web_view_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'root');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: RouteConstants.splashscreen,
  routes: [
    GoRoute(
      path: RouteConstants.splashscreen,
      pageBuilder: (context, state) => pageBuilder(const SplashScreen()),
    ),
    GoRoute(
      path: RouteConstants.drugScreen,
      pageBuilder: (context, state) => pageBuilder(const DrugScreen()),
    ),
    GoRoute(
      path: RouteConstants.qrScreen,
      pageBuilder: (context, state) => pageBuilder(const QRScreen()),
    ),
    GoRoute(
      path: RouteConstants.webViewScreen,
      pageBuilder: (context, state) => pageBuilder(const WebViewScreen()),
    ),
    GoRoute(
      path: RouteConstants.homeScreen,
      pageBuilder: (context, state) {
        final String data = state.extra as String? ?? '';
        return MaterialPage(
          child: HomeScreen(data: data),
        );
      },
    )
    
    // GoRoute(
    //   path: RouteConstants,
    //   pageBuilder: (context, state) => pageBuilder(const QRScreen()),
    // ),
    // GoRoute(
    //   path: RouteConstants.register,
    //   pageBuilder: (context, state) => pageBuilder(const RegisterScreen()),
    // ),
    // GoRoute(
    //   path: RouteConstants.onboardingScreen,
    //   pageBuilder: (context, state) => pageBuilder(const OnboardingScreen()),
    // ),
  ],
);

Page pageBuilder(Widget child) => Platform.isAndroid
    ? MaterialPage(child: child)
    : CupertinoPage(child: child);
