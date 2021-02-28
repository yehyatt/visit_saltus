// To parse this JSON data, do
//
//     final locationsModel = locationsModelFromJson(jsonString);

import 'dart:convert';

List<LocationsModel> locationsModelFromJson(String str) =>
    List<LocationsModel>.from(
        json.decode(str).map((x) => LocationsModel.fromJson(x)));

String locationsModelToJson(List<LocationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationsModel {
  LocationsModel({
    this.id,
    this.categoryid,
    this.locationtitle,
    this.locationdescription,
    this.locationimage,
  });

  int id;
  int categoryid;
  String locationtitle;
  String locationdescription;
  String locationimage;

  factory LocationsModel.fromJson(Map<String, dynamic> json) => LocationsModel(
        id: json["id"] == null ? null : json["id"],
        categoryid: json["categoryid"] == null ? null : json["categoryid"],
        locationtitle:
            json["locationtitle"] == null ? null : json["locationtitle"],
        locationdescription: json["locationdescription"] == null
            ? null
            : json["locationdescription"],
        locationimage:
            json["locationimage"] == null ? null : json["locationimage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "categoryid": categoryid == null ? null : categoryid,
        "locationtitle": locationtitle == null ? null : locationtitle,
        "locationdescription":
            locationdescription == null ? null : locationdescription,
        "locationimage": locationimage == null ? null : locationimage,
      };
}
