import 'package:get/get.dart';
import '../api/api_client.dart';
import '../utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/product_controller.dart';
import '../repositories/product_repo.dart';

Future<void>init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut( () => sharedPreferences);

  //api client
  Get.lazyPut( ()=> ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repositories
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
}