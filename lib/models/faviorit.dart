class FavoriteModel {
  String? id;
  String? title;
  String? dec;
  String? author;
  String? text;
  String? image;
  int? view;
  bool? fav;
  FavoriteModel({
    this.id,
    this.title,
    this.dec,
    this.author,
    this.text,
    this.image,
    this.view,
    this.fav,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dec = json['dec'];
    author = json['author'];
    text = json['text'];
    image = json['image'];
    view = json['view'];
    fav = json['fav'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dec': dec,
      'author': author,
      'text': text,
      'image': image,
      'view': view,
      'fav': fav,
    };
  }
}


  

