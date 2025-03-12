import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard.dart';
import 'helpers/dependencies.dart' as dep;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vendor Dashboard',
      home: VendorDashboard(),
    );
  }
}
