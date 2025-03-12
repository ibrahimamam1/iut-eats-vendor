import 'package:flutter/material.dart';
import 'new_product.dart';

class Product {
  final String name;
  final double price;
  Product(this.name, this.price);
}

List<Product> dummyProducts = [
  Product('Pizza', 12.99),
  Product('Burger', 8.99),
];

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Placeholder for edit action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Placeholder for delete action
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}