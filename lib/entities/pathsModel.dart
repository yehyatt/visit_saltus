// To parse this JSON data, do
//
//     final pathsModel = pathsModelFromJson(jsonString);

import 'dart:convert';

List<PathsModel> pathsModelFromJson(String str) =>
    List<PathsModel>.from(json.decode(str).map((x) => PathsModel.fromJson(x)));

String pathsModelToJson(List<PathsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PathsModel {
  PathsModel({
    this.id,
    this.pathtitle,
    this.pathplaces,
    this.pathtime,
    this.pathlocation,
    this.pathtype,
    this.pathimages,
  });

  int id;
  String pathtitle;
  String pathplaces;
  String pathtime;
  String pathlocation;
  String pathtype;
  String pathimages;

  factory PathsModel.fromJson(Map<String, dynamic> json) => PathsModel(
        id: json["id"] == null ? null : json["id"],
        pathtitle: json["pathtitle"] == null ? null : json["pathtitle"],
        pathplaces: json["pathplaces"] == null ? null : json["pathplaces"],
        pathtime: json["pathtime"] == null ? null : json["pathtime"],
        pathlocation:
            json["pathlocation"] == null ? null : json["pathlocation"],
        pathtype: json["pathtype"] == null ? null : json["pathtype"],
        pathimages: json["pathimages"] == null ? null : json["pathimages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "pathtitle": pathtitle == null ? null : pathtitle,
        "pathplaces": pathplaces == null ? null : pathplaces,
        "pathtime": pathtime == null ? null : pathtime,
        "pathlocation": pathlocation == null ? null : pathlocation,
        "pathtype": pathtype == null ? null : pathtype,
        "pathimages": pathimages == null ? null : pathimages,
      };
}
