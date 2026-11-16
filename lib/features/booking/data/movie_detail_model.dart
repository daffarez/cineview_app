class ShowtimeSchedule {
  final String cinemaName;
  final String cinemaLocation;
  final List<String> showtimes;

  ShowtimeSchedule({
    required this.cinemaName,
    required this.cinemaLocation,
    required this.showtimes,
  });
}

class MovieModel {
  final String id;
  final String title;
  final String genre;
  final String duration;
  final double rating;
  final String synopsis;
  final bool isNowShowing;
  final String posterColorHex;

  MovieModel({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.synopsis,
    required this.isNowShowing,
    required this.posterColorHex,
  });
}
