import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/movie_detail_model.dart';

final movieListProvider = Provider<List<MovieModel>>((ref) {
  return [
    MovieModel(
      id: 'm1',
      title: 'Interstellar (Re-Release)',
      genre: 'Sci-Fi / Adventure',
      duration: '169 min',
      rating: 8.7,
      synopsis: 'A team of space explorers travels through a wormhole in a bid to ensure humanity’s survival.',
      isNowShowing: true,
      posterColorHex: '0xFFE50914',
    ),
    MovieModel(
      id: 'm2',
      title: 'Avengers: Doomsday',
      genre: 'Action / Sci-Fi',
      duration: '145 min',
      rating: 9.1,
      synopsis: 'An interdimensional showdown brings together Earth’s mightiest heroes.',
      isNowShowing: true,
      posterColorHex: '0xFF1E3A8A',
    ),
    MovieModel(
      id: 'm3',
      title: 'Avatar 3: The Seed Bearer',
      genre: 'Sci-Fi / Fantasy',
      duration: '190 min',
      rating: 8.5,
      synopsis: 'A new clan is explored on the uncharted reaches of Pandora.',
      isNowShowing: false,
      posterColorHex: '0xFF065F46',
    ),
  ];
});

final dateListProvider = Provider<List<DateTime>>((ref) {
  final now = DateTime.now();
  return List.generate(30, (index) => now.add(Duration(days: index)));
});

final cinemaScheduleProvider = Provider.family<List<ShowtimeSchedule>, String>((
  ref,
  movieId,
) {
  return [
    ShowtimeSchedule(
      cinemaName: 'Cineview Grand Indonesia',
      cinemaLocation: 'Central Jakarta',
      showtimes: ['12:30', '15:15', '18:00', '20:45'],
    ),
    ShowtimeSchedule(
      cinemaName: 'Cineview Pondok Indah Mall',
      cinemaLocation: 'South Jakarta',
      showtimes: ['13:00', '15:45', '18:30', '21:15'],
    ),
    ShowtimeSchedule(
      cinemaName: 'Cineview Central Park',
      cinemaLocation: 'West Jakarta',
      showtimes: ['11:45', '14:30', '17:15', '20:00'],
    ),
  ];
});
