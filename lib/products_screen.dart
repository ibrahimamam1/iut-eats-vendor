import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'controllers/product_controller.dart';
import 'edit_product.dart';
import 'package:get/get.dart';
import 'new_product.dart';

class ProductsScreen extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    if (!controller.isLoaded) {
      controller.getProductList();
    }
    return GetBuilder<ProductController>(
      builder: (controller) {
        if (!controller.isLoaded) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('${product.price.toStringAsFixed(0)} BDT'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Get.to(EditProductScreen(
                            id: product.id,
                            name: product.name,
                            description: product.description,
                            price: product.price,
                            imageUrl: product.img,
                          ));

                        },
                      ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete ${product.name}?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                controller.deleteProduct(product.id);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }),

              
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
