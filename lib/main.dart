import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/motorcycle_controller.dart';
import 'views/manage_motorcycle_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,  // Tambahkan baris ini
      title: 'Motorcycle Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ManageMotorcycleScreen(),   
      initialBinding: BindingsBuilder(() {
        Get.put(MotorcycleController());
      }),
    );
  }
}
