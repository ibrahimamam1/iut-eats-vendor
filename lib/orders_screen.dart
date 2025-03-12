// lib/orders_screen.dart
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String customerName;
  final double totalAmount;
  final String status;
  Order(this.id, this.customerName, this.totalAmount, this.status);
}

List<Order> dummyOrders = [
  Order('001', 'John Doe', 25.50, 'Pending'),
  Order('002', 'Jane Smith', 15.00, 'Delivered'),
];

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: dummyOrders.length,
      itemBuilder: (context, index) {
        final order = dummyOrders[index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Text('${order.customerName} - \$${order.totalAmount.toStringAsFixed(2)}'),
            trailing: Text(
              order.status,
              style: TextStyle(
                color: order.status == 'Pending' ? Colors.orange : Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }
}