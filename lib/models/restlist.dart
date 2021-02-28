class Data {
  List<Items> data;
  Data({this.data});
  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Items> items = list.map((i) => Items.fromJson(i)).toList();

    return Data(data: items);
  }
}

class Items {
  String description;
  String image;
  String title;

  Items({this.description, this.image, this.title});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        description: json['description'] as String,
        image: json['image'] as String,
        title: json['title'] as String);
  }
}
