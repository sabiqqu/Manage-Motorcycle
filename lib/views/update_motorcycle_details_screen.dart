import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class UpdateMotorcycleDetailsScreen extends GetView<MotorcycleController> {
  final Motorcycle oldMotorcycle;
  final Motorcycle updatedMotorcycle;
  
  UpdateMotorcycleDetailsScreen({required this.oldMotorcycle, required this.updatedMotorcycle});

  final RxBool isRecommendation = true.obs;
  final TextEditingController priceController = TextEditingController();
  final RxInt currentIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    isRecommendation.value = updatedMotorcycle.isRecommendation;
    priceController.text = updatedMotorcycle.price.toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Get.back(),
        ),
        title: Text('Update Motorcycle', style: TextStyle(color: Colors.blue)),
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
              child: Image.asset(updatedMotorcycle.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Detail Motor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildDetailRow('Merk Motor', updatedMotorcycle.brand),
                    _buildDetailRow('Motor Name', updatedMotorcycle.model),
                    _buildDetailRow('Type Motor', updatedMotorcycle.type),
                    _buildDetailRow('Plat Motor', updatedMotorcycle.licensePlate),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Is Recommendation?', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            _buildRecommendationDropdown(),
            SizedBox(height: 16),
            Text('Price/Day', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            _buildPriceInput(),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateMotorcycle,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
      value: isRecommendation.value,
      items: [
        DropdownMenuItem<bool>(value: true, child: Text('Yes')),
        DropdownMenuItem<bool>(value: false, child: Text('No')),
      ],
      onChanged: (bool? newValue) {
        if (newValue != null) {
          isRecommendation.value = newValue;
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

  void _updateMotorcycle() {
    if (priceController.text.isNotEmpty) {
      final finalUpdatedMotorcycle = Motorcycle(
        brand: updatedMotorcycle.brand,
        model: updatedMotorcycle.model,
        type: updatedMotorcycle.type,
        licensePlate: updatedMotorcycle.licensePlate,
        price: double.parse(priceController.text),
        imageUrl: updatedMotorcycle.imageUrl,
        isRecommendation: isRecommendation.value,
      );

      controller.updateMotorcycle(oldMotorcycle, finalUpdatedMotorcycle);
      Get.back();
      Get.back();  // Go back twice to return to the manage motorcycle screen
      Get.snackbar(
        'Success',
        'Motorcycle updated successfully',
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