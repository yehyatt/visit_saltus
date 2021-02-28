import 'dart:convert';

import 'package:http/http.dart';
import 'package:visit_saltus/entities/categoriesModel.dart';
import 'package:visit_saltus/entities/locationsModel.dart';
import 'package:visit_saltus/entities/pathsModel.dart';
import 'package:visit_saltus/entities/userModel.dart';
import 'package:visit_saltus/shared/app_urls.dart';

class ServicesProvider {
  bool isLoading = false;

  ServicesProvider.initWith();

  ServicesProvider();

  void reset() {
    isLoading = false;
  }

  Future<UserModel> login(String phone, String password) async {
    var url = AppUrls.loginUrl();
    Map<String, String> headers = {"Content-type": "application/json"};
    var body = jsonEncode({"phone": phone, "password": password});
    isLoading = true;

    print("SendApi Body: " + body.toString());
    Response apiResponse = await post(url, headers: headers, body: body);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final userModel = userModelFromJson(apiResponse.body);
      isLoading = false;
      return userModel;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<UserModel> register(String firstName, String lastName, String userName,
      String password, String phone, String image) async {
    var url = AppUrls.registerUrl();
    Map<String, String> headers = {"Content-type": "application/json"};
    var body = jsonEncode({
      "firstname": firstName,
      "lastname": lastName,
      "email": userName,
      "password": password,
      "image": image,
      "phone": phone
    });
    isLoading = true;

    print("SendApi Body: " + body.toString());
    Response apiResponse = await post(url, headers: headers, body: body);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final userModel = userModelFromJson(apiResponse.body);
      isLoading = false;
      return userModel;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<UserModel> editProfile(int id, String firstName, String lastName,
      String userName, String phone, String image) async {
    var url = AppUrls.editUserUrl();
    Map<String, String> headers = {"Content-type": "application/json"};
    var body = jsonEncode({
      "id": id,
      "firstname": firstName,
      "lastname": lastName,
      "email": userName,
      "image": image,
      "phone": phone
    });
    isLoading = true;

    print("SendApi Body: " + body.toString());
    Response apiResponse = await post(url, headers: headers, body: body);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final userModel = userModelFromJson(apiResponse.body);
      isLoading = false;
      return userModel;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<List<PathsModel>> getAllPaths() async {
    var url = AppUrls.getPaths();
    Map<String, String> headers = {"Content-type": "application/json"};
    isLoading = true;

    Response apiResponse = await get(url, headers: headers);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final pathList = pathsModelFromJson(apiResponse.body);
      isLoading = false;
      return pathList;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<List<CategoriesModel>> getAllCategories() async {
    var url = AppUrls.getCategories();
    Map<String, String> headers = {"Content-type": "application/json"};
    isLoading = true;

    Response apiResponse = await post(url, headers: headers);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final categoriesList = categoriesModelFromJson(apiResponse.body);
      isLoading = false;
      return categoriesList;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<List<LocationsModel>> getLocationsByCategoryId(int CategoryId) async {
    var url = AppUrls.getLocationsByCategoryId(CategoryId);
    Map<String, String> headers = {"Content-type": "application/json"};
    isLoading = true;

    Response apiResponse = await get(url, headers: headers);
    print("SendApi Response status: ${apiResponse.statusCode}");
    print("SendApi ${apiResponse.headers}");
    print("SendApi ${apiResponse.request}");
    print("SendApi" + apiResponse.body);

    try {
      final locationsList = locationsModelFromJson(apiResponse.body);
      isLoading = false;
      return locationsList;
    } catch (e) {
      isLoading = false;
    }
  }
}
