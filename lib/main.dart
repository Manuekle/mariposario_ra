import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/hub_screen.dart';
import 'screens/species_screen.dart';
import 'screens/preparation_screen.dart';
import 'screens/ar_experience_screen.dart';
import 'screens/species_selection_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/qr_scan_screen.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MariposarioApp(),
    ),
  );
}

class MariposarioApp extends StatelessWidget {
  const MariposarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Mariposario RA',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/hub': (context) => HubScreen(),
        '/species': (context) => SpeciesScreen(),
        '/preparation': (context) => PreparationScreen(),
        '/ar': (context) => ARExperienceScreen(),
        '/species-selection': (context) => SpeciesSelectionScreen(),
        '/settings': (context) => SettingsScreen(),
        '/qr': (context) => QRScanScreen(),
      },
    );
  }
}
