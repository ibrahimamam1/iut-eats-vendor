import 'package:get/get.dart';
import '../models/order_model.dart';
import '../repositories/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  List<dynamic> _orderList = [];
  List<dynamic> get orderList => _orderList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  @override
  void onInit() {
    super.onInit();
    getOrderList();
  }

  Future<void> getOrderList() async {
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      print("Got orders");
      print(response.body.toString());
      final Map<String, dynamic> data = response.body;
      final List<dynamic> ordersJson = data['orders'];
      _orderList = ordersJson.map((json) => Order.fromJson(json)).toList();
      _isLoaded = true;
      update();
    } else {
      print("Failed to load orders: ${response.statusCode}");
      _isLoaded = true;
      update();
    }
  }
  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    final index = _orderList.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final updatedOrder = Order(
        _orderList[index].id,
        _orderList[index].customerName,
        _orderList[index].customerPhone,
        _orderList[index].deliveryAddress,
        _orderList[index].totalAmount,
        newStatus,
        _orderList[index].orderItems,
      );
      _orderList[index] = updatedOrder;
      update();
    }
  }
}