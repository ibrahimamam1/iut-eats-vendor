import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/order_model.dart';
import 'controllers/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();

    return GetBuilder<OrderController>(
      builder: (controller) {
        if (!controller.isLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orderList.isEmpty) {
          return const Center(child: Text('No orders available'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.orderList.length,
          itemBuilder: (context, index) {
            final order = controller.orderList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${order.id}'),
                    Text('Customer: ${order.customerName}'),
                    Text('Status: ${order.orderStatus}',
                      style: TextStyle(
                        color: order.orderStatus == 'delivered' ? Colors.green : Colors.orange,
                      ),
                    ),
                    Text('Items:'),
                    // Debug print (remove after testing)
                    Builder(builder: (context) {
                      print('Order ${order.id}: items = ${order.orderItems}');
                      return const SizedBox.shrink();
                    }),
                    ...order.orderItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text('${item['name']} x ${item['quantity']}'),
                      );
                    }).toList(),
                    if (order.orderStatus == 'pending')
                      ElevatedButton(
                        onPressed: () {
                          controller.updateOrderStatus(order.id, 'delivered');
                        },
                        child: Text('Delivered'),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}