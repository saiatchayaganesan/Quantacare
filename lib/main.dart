import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:qc/screens/features/health_monitoring/sensor_data_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void logButtonClick() {
    analytics.logEvent(
      name: "button_click",
      parameters: {"button_name": "StartButton"},
    );
  }

  // Load theme preference
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('dark_mode_enabled') ?? false;

  runApp(QuantacareApp(isDarkMode: isDarkMode));
}

class QuantacareApp extends StatefulWidget {
  final bool isDarkMode;
  const QuantacareApp({super.key, required this.isDarkMode});

  @override
  State<QuantacareApp> createState() => QuantacareAppState();
}

class QuantacareAppState extends State<QuantacareApp> {
  late ValueNotifier<ThemeMode> themeNotifier;

  @override
  void initState() {
    super.initState();
    themeNotifier = ValueNotifier(widget.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Quantacare',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: const SplashScreen(),
          routes: {
            '/sensor': (context) => const SensorDataScreen(),
          },

        );
      },
    );
  }

  // Function to toggle theme
  void toggleTheme(bool isDark) async {
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode_enabled', isDark);
  }
}
