class UserStorieModel {
  String? id;

  UserStorieModel({
    this.id,
  });

  UserStorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
