class Movie {
  String posterPath;
  String originalTitle;
  String voteAverage;
  String releaseDate;
  String overView;

  Movie(
      {required this.posterPath,
      required this.originalTitle,
      required this.voteAverage,
      required this.releaseDate,
      required this.overView});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        posterPath: json['poster_path'],
        originalTitle: json['original_title'],
        voteAverage: json['vote_average'].toString(),
        releaseDate: json['release_date'],
        overView: json['overview']);
  }
}
