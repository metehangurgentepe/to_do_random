class BooksModel {
  String? author;
  String? country;
  String? imageLink;
  String? language;
  String? link;
  int? pages;
  String? title;
  int? year;

  BooksModel(
      {this.author,
        this.country,
        this.imageLink,
        this.language,
        this.link,
        this.pages,
        this.title,
        this.year});

  BooksModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    country = json['country'];
    imageLink = json['imageLink'];
    language = json['language'];
    link = json['link'];
    pages = json['pages'];
    title = json['title'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['country'] = this.country;
    data['imageLink'] = this.imageLink;
    data['language'] = this.language;
    data['link'] = this.link;
    data['pages'] = this.pages;
    data['title'] = this.title;
    data['year'] = this.year;
    return data;
  }
}
