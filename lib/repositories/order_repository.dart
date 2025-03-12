import 'package:get/get.dart';
import '../api/api_client.dart';
import '../utils/app_constants.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_URI);
  }

}
