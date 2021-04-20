class UsersData {
  int id;
  String title;

  UsersData({this.id, this.title,});

  ///Extract json Object from Map object
  UsersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  ///Convert  json Object into Map Object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}