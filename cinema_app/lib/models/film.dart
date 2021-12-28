class Film {
  int id;
  String title;
  String synopsis;
  double rating;
  int length;

  Film(this.id, this.title, this.synopsis, this.rating, this.length);

  factory Film.fromJson(
    Map<String, dynamic> map,
  ) =>
      Film(
        map["id"],
        map["titre"],
        map["description"],
        map["rating"],
        map["dure"],
      );
}
