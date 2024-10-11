import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import '../views/detail_motorcycle_screen.dart';

class MotorcycleListItem extends GetView<MotorcycleController> {
  final Motorcycle motorcycle;

  const MotorcycleListItem({Key? key, required this.motorcycle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => Get.to(() => DetailMotorcycleScreen(motorcycle: motorcycle)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  motorcycle.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      motorcycle.brand,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      motorcycle.model,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      motorcycle.licensePlate,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      'Rp${motorcycle.price.toStringAsFixed(0)}/Day',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.chevron_right, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
