import 'package:flutter/material.dart';

import 'screens/idea_screen.dart';

void main() {
  runApp(const QuickPitchApp());
}

class QuickPitchApp extends StatelessWidget {
  const QuickPitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickPitch AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const IdeaScreen(),
    );
  }
}
