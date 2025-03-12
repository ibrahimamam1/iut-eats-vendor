import 'package:get/get.dart';
import '../api/api_client.dart';
import '../utils/app_constants.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }

  Future<Response> addProduct(FormData formData) async {
    return await apiClient.postData(AppConstants.UPLOAD_URL, formData);
  }
  Future<Response> editProduct(FormData formData) async {
    return await apiClient.postData(AppConstants.EDIT_PRODUCT_URL, formData);
  }
  Future<Response> deleteProduct(int id) async {
    return await apiClient.getData(AppConstants.DELETE_PRODUCT_URL + id.toString());
  }
}
