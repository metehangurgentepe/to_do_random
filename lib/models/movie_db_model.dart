class MovieDbModel {
  List<String>? genres;
  List<Movies>? movies;

  MovieDbModel({this.genres, this.movies});

  MovieDbModel.fromJson(Map<String, dynamic> json) {
    genres = json['genres'].cast<String>();
    if (json['movies'] != null) {
      movies = <Movies>[];
      json['movies'].forEach((v) {
        movies!.add(new Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genres'] = this.genres;
    if (this.movies != null) {
      data['movies'] = this.movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  int? id;
  String? title;
  String? year;
  String? runtime;
  List<String>? genres;
  String? director;
  String? actors;
  String? plot;
  String? posterUrl;

  Movies(
      {this.id,
        this.title,
        this.year,
        this.runtime,
        this.genres,
        this.director,
        this.actors,
        this.plot,
        this.posterUrl});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    runtime = json['runtime'];
    genres = json['genres'].cast<String>();
    director = json['director'];
    actors = json['actors'];
    plot = json['plot'];
    posterUrl = json['posterUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['runtime'] = this.runtime;
    data['genres'] = this.genres;
    data['director'] = this.director;
    data['actors'] = this.actors;
    data['plot'] = this.plot;
    data['posterUrl'] = this.posterUrl;
    return data;
  }
}
