import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Define a cor da barra de status do sistema (Android/iOS)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Jogos',
      debugShowCheckedModeBanner: false,

      // ─── Tema Global ───────────────────────────────────────────────
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          surface: AppColors.background,
          primary: AppColors.accent,
          onPrimary: AppColors.textPrimary,
        ),

        scaffoldBackgroundColor: AppColors.background,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.textPrimary,
            fontFamily: 'SF Pro Text',
          ),
        ),

        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.accent,
          thumbColor: AppColors.accent,
          overlayColor: AppColors.accent.withOpacity(0.15),
          inactiveTrackColor: AppColors.surface,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}

// ─── Paleta de Cores Centralizada ───────────────────────────────────────────
// Manter todas as cores em um único lugar facilita manutenção e consistência
abstract class AppColors {
  static const Color background = Color(0xFF060F18);    // Azul muito escuro
  static const Color surface    = Color(0xFF0D1E2D);    // Card base
  static const Color surfaceAlt = Color(0xFF122336);    // Card hover / destaque
  static const Color accent     = Color(0xFF00B4FF);    // Azul ciano principal
  static const Color accentGlow = Color(0x3300B4FF);    // Brilho para sombras
  static const Color star       = Color(0xFFFFAA3C);    // Estrela de nota
  static const Color textPrimary   = Color(0xFFE8EEF4); // Texto principal
  static const Color textSecondary = Color(0xFF6B8A9E); // Texto secundário
  static const Color divider        = Color(0xFF1A3048); // Linha divisória
}