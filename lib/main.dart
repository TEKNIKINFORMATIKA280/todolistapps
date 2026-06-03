import 'package:flutter/material.dart';
import 'pages/main_screen.dart';
import 'theme/app_theme.dart';

// Global notifiers for theme and profile management
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
final ValueNotifier<String> userNameNotifier = ValueNotifier('Rafael Paulus Sitompul');
final ValueNotifier<String> userStatusNotifier = ValueNotifier('Mahasiswa');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'To-Do Mahasiswa',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          home: const MainScreen(),
        );
      },
    );
  }
}
