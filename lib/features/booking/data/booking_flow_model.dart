class CinemaLocation {
  final String id;
  final String name;
  CinemaLocation({required this.id, required this.name});
}

class MovieModel {
  final String id;
  final String title;
  final String genre;
  final String duration;
  MovieModel({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
  });
}
