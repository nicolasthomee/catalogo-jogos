// 

class Game {
  String name;
  String genre;
  String platform;

  int? year;
  String? status;
  double? rating;

  Game({
    required this.name,
    required this.genre,
    required this.platform,
    this.year,
    this.status,
    this.rating,
  });
}