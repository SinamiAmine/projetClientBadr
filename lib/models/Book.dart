class Book {
  String? error;
  String? title;
  String? subTitle;
  String? authors;
  String? publisher;
  String? language;
  String? isbn10;
  String? isbn13;
  String? pages;
  String? year;
  String? rating;
  String? desc;
  String? price;
  String? image;
  String? url;
  Object? pdf;

  Book({
    this.error,
    this.title,
    this.subTitle,
    this.authors,
    this.publisher,
    this.language,
    this.isbn10,
    this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.image,
    this.url,
    this.pdf,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      error: json["error"] as String?,
      title: json["title"] as String?,
      subTitle: json['subTitle'] as String?,
      authors: json['authors'] as String?,
      publisher: json['publisher'] as String?,
      language: json['language'] as String?,
      isbn10: json['isbn10'] as String?,
      isbn13: json['isbn13'] as String?,
      pages: json['pages'] as String?,
      year: json['year'] as String?,
      rating: json['rating'] as String?,
      desc: json['desc'] as String?,
      price: json['price'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
      pdf: json['pdf'] as Object?,
    );
  }
}
