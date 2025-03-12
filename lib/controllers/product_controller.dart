import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repositories/product_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_connect.dart';


class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProductList() async {
    Response response = await productRepo.getProductList();
    if (response.statusCode == 200) {
      print("Got products");
      _productList = [];
      _productList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      // Handle error if needed.
    }
  }

  Future<void> addProduct(
      String name, String description, int price, XFile img) async {
    final bytes = await img.readAsBytes();
    print("creating form data");
    final formData = FormData({
      'name': name,
      'description': description,
      'price': price,
      // Use the constructor directly without .fromBytes.
      'img': MultipartFile(bytes, filename: img.name),
    });

    Response response = await productRepo.addProduct(formData);
    if (response.statusCode == 200) {
      print("Product added");
    } else {
      print("Error: ${response.statusCode}");
      print(response.body.toString());
    }
  }

  Future<void> editProduct(
      int id, String name, String description, int price) async {
    print("creating form data");
    final formData = FormData({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    });
  }
    Future<void> deleteProduct(int id) async {
      Response response = await productRepo.deleteProduct(id);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product deleted succesfully');
      } else {
        Get.snackbar('Error', response.statusText!);
        print("Error: ${response.statusCode}");
        print(response.body.toString());
      }
    }
  
}
