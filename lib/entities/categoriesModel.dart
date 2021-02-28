// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  CategoriesModel({
    this.id,
    this.categorytitle,
  });

  int id;
  String categorytitle;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"] == null ? null : json["id"],
        categorytitle:
            json["categorytitle"] == null ? null : json["categorytitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "categorytitle": categorytitle == null ? null : categorytitle,
      };
}
