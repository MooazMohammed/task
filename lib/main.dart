import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'shared/widgets/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const EStateApp());
}

class EStateApp extends StatelessWidget {
  const EStateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إيستيت',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // ── RTL is set here globally for the entire app ──────────
      // This ensures ALL widgets (ListView, Row, icons, etc.)
      // automatically use RTL direction without manual overrides.
      locale: const Locale('ar', 'EG'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],

      // Force RTL for the entire widget tree
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      home: const MainNavigation(),
    );
  }
}
