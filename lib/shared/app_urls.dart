class AppUrls {
  static const String BASE_URL = 'https://visit-saltus.herokuapp.com';

  static String registerUrl() {
    return BASE_URL + '/register';
  }

  static String loginUrl() {
    return BASE_URL + '/login';
  }

  static String editUserUrl() {
    return BASE_URL + '/edituser';
  }

  static String getCategories() {
    return BASE_URL + '/getcategories';
  }

  static String getLocationsByCategoryId(int Id) {
    return BASE_URL + '/getlocationsbycategoryid/$Id';
  }

  static String getPaths() {
    return BASE_URL + '/getpaths';
  }
}
