import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/booking/presentation/home_movie_screen.dart';

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
      locale: const Locale('en'),
      theme: AppTheme.darkTheme,
      home: const HomeMovieScreen(),
    );
  }
}
