import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medgrid_app/core/routing/router.dart';
import 'package:medgrid_app/core/services/inject_container.dart';
import 'package:medgrid_app/core/styles/app_themes.dart';
import 'package:medgrid_app/src/authentication/presentation/cubit/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticaationCubit>(),
      child: MaterialApp.router(
                      routerConfig: router,
                      title: 'Catalyst Research',
                      debugShowCheckedModeBanner: false,
                      themeMode: ThemeMode.system,
                      theme: AppThemes.lightTheme,
                      darkTheme: AppThemes.lightTheme,
                    ),
    );
  }
}