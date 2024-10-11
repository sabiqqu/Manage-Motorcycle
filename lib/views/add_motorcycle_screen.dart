import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import 'add_motorcycle_details_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
class AddMotorcycleScreen extends GetView<MotorcycleController> {
  final _formKey = GlobalKey<FormState>();
  final RxString selectedBrand = 'Honda'.obs;
  final RxString selectedType = 'Matic'.obs;
  final TextEditingController modelController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();
  final RxString selectedImage = ''.obs;
  final RxInt currentIndex = 2.obs;  // Tambahkan ini di awal kelas

  // Daftar gambar motor dari asset
  final List<String> motorImages = [
    'assets/motor/Xmax.jpg',
    'assets/motor/Aerox.jpg',
    'assets/motor/Nmax.jpg',
    // Tambahkan lebih banyak gambar sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    // Inisialisasi gambar pertama sebagai default
    if (selectedImage.value.isEmpty && motorImages.isNotEmpty) {
      selectedImage.value = motorImages[0];
    }

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
                  Get.to(() => AddMotorcycleDetailsScreen(
                    imageUrl: selectedImage.value,
                    brand: selectedBrand.value,
                    model: modelController.text,
                    type: selectedType.value,
                    licensePlate: licensePlateController.text,
                    isRecommendation: true,  // Tambahkan ini, atau gunakan nilai default yang sesuai
                  ));
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,  // Mengubah warna teks menjadi putih
                  fontSize: 16,  // Anda bisa menyesuaikan ukuran font jika diperlukan
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,  // Memastikan latar belakang tetap biru
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),  // Membuat sudut tombol lebih bulat
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
    Get.dialog(
      AlertDialog(
        title: Text('Choose Motor Picture'),
        content: Container(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: motorImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  selectedImage.value = motorImages[index];
                  Get.back();
                },
                child: Image.asset(motorImages[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
      ),
    );
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