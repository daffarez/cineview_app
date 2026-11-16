import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/config/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: CineViewApp()));
}

class CineViewApp extends StatelessWidget {
  const CineViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineView',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'CineView Initialized 🎬',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
