import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import 'edit_motorcycle_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DetailMotorcycleScreen extends GetView<MotorcycleController> {
  final Motorcycle motorcycle;

  DetailMotorcycleScreen({required this.motorcycle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Get.back(),
        ),
        title: Text('Detail Manage Motorcycle',
            style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final updatedMotorcycle = controller.motorcycles.firstWhere(
          (m) => m.licensePlate == motorcycle.licensePlate,
          orElse: () => motorcycle,
        );
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200, // Sesuaikan tinggi sesuai kebutuhan
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    updatedMotorcycle.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Detail Motor',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        _buildDetailRow('Merk Motor', updatedMotorcycle.brand),
                        _buildDetailRow('Motor Name', updatedMotorcycle.model),
                        _buildDetailRow('Type Motor', updatedMotorcycle.type),
                        _buildDetailRow(
                            'Plat Motor', updatedMotorcycle.licensePlate),
                        _buildDetailRow('Price/day',
                            'Rp${updatedMotorcycle.price.toStringAsFixed(0)}',
                            isPrice: true),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _showDeleteConfirmation(context),
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.red,
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => EditMotorcycleScreen(
                            motorcycle: updatedMotorcycle)),
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2.obs),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPrice ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Motorcycle'),
        content: Text("Are you sure you want to delete this motorcycle?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () {
              controller.deleteMotorcycle(motorcycle);
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
