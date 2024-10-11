import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class AddMotorcycleDetailsScreen extends GetView<MotorcycleController> {
  final String imageUrl;
  final String brand;
  final String model;
  final String type;
  final String licensePlate;
  final bool isRecommendation;  // Tambahkan ini
  final RxInt currentIndex = 2.obs;  // Tambahkan ini

  AddMotorcycleDetailsScreen({
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.type,
    required this.licensePlate,
    required this.isRecommendation,  // Tambahkan ini
  });

  final RxBool isRecommendationRx = true.obs;  // Ubah ini menjadi RxBool
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isRecommendationRx.value = isRecommendation;  // Inisialisasi nilai Rx dengan nilai yang diterima

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Get.back(),
        ),
        title: Text('Add New Motorcycle', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imageUrl,
                  width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Detail Motor',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildDetailRow('Merk Motor', brand),
                    _buildDetailRow('Motor Name', model),
                    _buildDetailRow('Type Motor', type),
                    _buildDetailRow('Plat Motor', licensePlate),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Is Recommendation?',
                style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            _buildRecommendationDropdown(),
            SizedBox(height: 16),
            Text('Price/Day', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            _buildPriceInput(),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addNewMotorcycle,
                    child: Text('Add New', style: TextStyle(color: Colors.green)), // Ubah warna teks menjadi hijau
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Ubah warna latar belakang menjadi putih
                      onPrimary: Colors.green, // Ubah warna splash (saat ditekan) menjadi hijau
                      side: BorderSide(color: Colors.green), // Tambahkan border hijau
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecommendationDropdown() {
    return Obx(() => DropdownButtonFormField<bool>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          value: isRecommendationRx.value,
          items: [
            DropdownMenuItem<bool>(value: true, child: Text('Yes')),
            DropdownMenuItem<bool>(value: false, child: Text('No')),
          ],
          onChanged: (bool? newValue) {
            if (newValue != null) {
              isRecommendationRx.value = newValue;
            }
          },
        ));
  }

  Widget _buildPriceInput() {
    return TextFormField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        prefixText: 'Rp ',
      ),
    );
  }

  void _addNewMotorcycle() {
    if (priceController.text.isNotEmpty) {
      final newMotorcycle = Motorcycle(
        brand: brand,
        model: model,
        type: type,
        licensePlate: licensePlate,
        price: double.parse(priceController.text),
        imageUrl: imageUrl,
        isRecommendation: isRecommendationRx.value,
      );

      controller.addMotorcycle(newMotorcycle);

      Get.back();
      Get.back(); // Go back twice to return to the manage motorcycle screen
      Get.snackbar(
        'Success',
        'New motorcycle added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please enter a price',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
