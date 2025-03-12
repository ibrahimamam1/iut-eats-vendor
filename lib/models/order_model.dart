class Order {
  final int id;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final double totalAmount;
  final String orderStatus;
  final List<Map<String, dynamic>> orderItems;

  Order(
      this.id,
      this.customerName,
      this.customerPhone,
      this.deliveryAddress,
      this.totalAmount,
      this.orderStatus,
      this.orderItems,
      );

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> orderItems = [];
    if (json['order_items'] is List && json['order_items'].isNotEmpty) {
      final items = json['order_items'] as List;
      if (items.first is String) {
        orderItems = items.map((item) => {'name': item as String, 'quantity': 1}).toList();
      } else if (items.first is Map) {
        orderItems = items.map((item) => {
          'name': (item as Map)['name'] as String,
          'quantity': (item as Map)['price'] as int
        }).toList();
      }
    }

    final orderAmount = json['order_amount'];
    final double totalAmount = orderAmount is String ? double.parse(orderAmount) : (orderAmount as num).toDouble();

    return Order(
      json['id'] as int,
      json['user_name'] as String,
      json['user_phone'] as String,
      json['delivery_address'] as String,
      totalAmount,
      json['delivery_status'] as String,
      orderItems,
    );
  }
}