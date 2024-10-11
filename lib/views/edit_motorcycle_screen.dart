import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import 'update_motorcycle_details_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class EditMotorcycleScreen extends GetView<MotorcycleController> {
  final Motorcycle motorcycle;
  final RxInt currentIndex = 2.obs;

  EditMotorcycleScreen({required this.motorcycle});

  final _formKey = GlobalKey<FormState>();
  late final RxString selectedBrand;
  late final TextEditingController modelController;
  late final RxString selectedType;
  late final TextEditingController licensePlateController;
  final RxString selectedImage = ''.obs;

  @override
  Widget build(BuildContext context) {
    selectedBrand = motorcycle.brand.obs;
    modelController = TextEditingController(text: motorcycle.model);
    selectedType = motorcycle.type.obs;
    licensePlateController = TextEditingController(text: motorcycle.licensePlate);
    selectedImage.value = motorcycle.imageUrl;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Get.back(),
        ),
        title: Text('Edit Motorcycle', style: TextStyle(color: Colors.blue, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text('Motor Picture', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 8),
            _buildImagePicker(),
            SizedBox(height: 16),
            Text('Merk Motor', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 8),
            _buildDropdown('Merk Motor', selectedBrand, ['Honda', 'Yamaha', 'Suzuki']),
            SizedBox(height: 16),
            Text('Motor Name', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 8),
            _buildTextField('Motor Name', modelController),
            SizedBox(height: 16),
            Text('Type Motor', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 8),
            _buildDropdown('Type Motor', selectedType, ['Matic', 'Manual']),
            SizedBox(height: 16),
            Text('Plat Motor', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            SizedBox(height: 8),
            _buildTextField('Plat Motor', licensePlateController),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => UpdateMotorcycleDetailsScreen(
                    oldMotorcycle: motorcycle,
                    updatedMotorcycle: Motorcycle(
                      brand: selectedBrand.value,
                      model: modelController.text,
                      type: selectedType.value,
                      licensePlate: licensePlateController.text,
                      price: motorcycle.price,
                      imageUrl: selectedImage.value,
                      isRecommendation: motorcycle.isRecommendation,
                    ),
                  ));
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
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

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _showImagePickerDialog,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(() => selectedImage.value.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                selectedImage.value,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Icon(Icons.add_photo_alternate, size: 50, color: Colors.blue),
            )
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    // Implement image picker dialog here
  }

  Widget _buildDropdown(String label, RxString selectedValue, List<String> items) {
    return Obx(() => DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      value: selectedValue.value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          selectedValue.value = newValue;
        }
      },
      validator: (value) => value == null ? 'Please select a $label' : null,
    ));
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
