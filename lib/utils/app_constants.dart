class AppConstants {
  static const String APP_NAME = "Iut Eats";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://127.0.0.1:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String SEARCH_PRODUCT_URI = "/api/v1/products/search?query=";
  // static const String DRINKS_URI="/api/v1/products/drinks";
  static const String UPLOAD_URL = "/api/v1/products/create";
  static const String EDIT_PRODUCT_URL = "/api/v1/products/edit";
  static const String DELETE_PRODUCT_URL = "/api/v1/products/delete?id=";
  static const String ORDER_URI = "/api/v1/products/get_user_order";



  static const String TOKEN = "TOKEN";
}
