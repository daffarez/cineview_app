import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_data_provider.dart';
import 'movie_detail_screen.dart';

class HomeMovieScreen extends ConsumerWidget {
  const HomeMovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieListProvider);
    final nowShowing = movies.where((m) => m.isNowShowing).toList();
    final comingSoon = movies.where((m) => !m.isNowShowing).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CineView 🎬',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Now showing (carousel / horizontal list)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Now Showing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: nowShowing.length,
                itemBuilder: (context, index) {
                  final movie = nowShowing[index];
                  return _buildMovieCard(context, movie);
                },
              ),
            ),
            const SizedBox(height: 24),

            // Coming soon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: comingSoon.length,
                itemBuilder: (context, index) {
                  final movie = comingSoon[index];
                  return _buildMovieCard(context, movie, isComingSoon: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Movie poster card (Material UI placeholder)
  Widget _buildMovieCard(
    BuildContext context,
    dynamic movie, {
    bool isComingSoon = false,
  }) {
    return GestureDetector(
      onTap: () {
        // Open movie details only for movies that are now showing.
        if (!isComingSoon) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        }
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(movie.posterColorHex)),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            Text(
              movie.genre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
