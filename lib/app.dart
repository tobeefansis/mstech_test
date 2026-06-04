import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return GlassMorphismThemeProvider(
      data: GlassMorphismThemeData(
        defaultBlurIntensity: 18.0,
        defaultOpacity: 0.13,
        lightGlassColor: const Color(0x20FFFFFF),
        darkGlassColor: const Color(0x20FFFFFF),
        enableSpecularHighlights: true,
        buttonTheme: GlassMorphismButtonThemeData(
          height: 52.0,
          borderRadius: BorderRadius.circular(16),
        ),
        cardTheme: GlassMorphismCardThemeData(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: MaterialApp.router(
        title: 'MSTech App',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF9C8FFF),
            secondary: Color(0xFF64B5F6),
            surface: Colors.transparent,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
