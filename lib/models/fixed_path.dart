


class FixedPath {
  String name;
  String image;
  String tourLocation;
  String type;
  String timeDate;
  List<String>places;

  FixedPath({this.name, this.image, this.places,this.tourLocation,this.type,this.timeDate});

  factory FixedPath.fromJson(Map<String, dynamic> json) {
    return FixedPath(
        name: json['name'] as String,
        image: json['image'] as String,
        tourLocation: json['tourLocation'] as String,
        type: json['type'] as String,
        places: (json['places'] as List).map((map) => ("$map")).toList(),
      timeDate: json['time_date']as String
        );
  }
}