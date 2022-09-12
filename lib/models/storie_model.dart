class StorieModel {
  String? id;
  String? title;
  String? dec;
  String? author;
  String? text;
  String? image;
  int? view;

  StorieModel({
    this.id,
    this.title,
    this.dec,
    this.author,
    this.text,
    this.image,
    this.view,
  
  });

  StorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dec = json['dec'];
    author = json['author'];
    text = json['text'];
    image = json['image'];
    view = json['view'];
    
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
      
    };
  }
}
