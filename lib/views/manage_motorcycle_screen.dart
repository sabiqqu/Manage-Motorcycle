import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motorcycle_controller.dart';
import '../models/motorcycle.dart';
import 'detail_motorcycle_screen.dart';
import 'add_motorcycle_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ManageMotorcycleScreen extends GetView<MotorcycleController> {
  final RxInt currentIndex = 2.obs;
  final RxString selectedFilter = 'All'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Motorcycle'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterButtons(),
          // _buildExampleMotorcycleCard(),
          Expanded(
            child: Obx(() => _buildMotorcycleList()),
          ),
          _buildAddNewButton(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Searching',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          // Implement search functionality
          controller.searchMotorcycles(value);
        },
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
        children: [
          SizedBox(width: 16),
          _buildFilterChip('All'),
          _buildFilterChip('Honda'),
          _buildFilterChip('Yamaha'),
          _buildFilterChip('Suzuki'),
          SizedBox(width: 16),
        ],
      )),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selectedFilter.value == label,
        onSelected: (selected) {
          if (selected) {
            selectedFilter.value = label;
            controller.filterMotorcycles(label);
          }
        },
        backgroundColor: Colors.grey[300],
        selectedColor: Colors.blue,
        labelStyle: TextStyle(
          color: selectedFilter.value == label ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // Widget _buildExampleMotorcycleCard() {
  //   return InkWell(
  //     onTap: () {
  //       // Membuat objek Motorcycle contoh
  //       Motorcycle exampleMotorcycle = Motorcycle(
  //         brand: 'Honda',
  //         model: 'PCX 2024',
  //         type: 'Matic',  // Menambahkan parameter 'type'
  //         licensePlate: 'KH 2123 WG',
  //         price: 150000,
  //         imageUrl: 'assets/motor/pcx.jpg',
  //         isRecommendation: true,  // Menambahkan parameter isRecommendation
  //       );
  //       Get.to(() => DetailMotorcycleScreen(motorcycle: exampleMotorcycle));
  //     },
  //     child: Card(
  //       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.all(12),
  //         child: Row(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(8),
  //               child: Image.asset(
  //                 'assets/motor/pcx.jpg',
  //                 width: 80,
  //                 height: 60,
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Container(
  //                     width: 80,
  //                     height: 60,
  //                     color: Colors.grey[300],
  //                     child: Icon(Icons.error, color: Colors.red),
  //                   );
  //                 },
  //               ),
  //             ),
  //             SizedBox(width: 12),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Honda', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
  //                   SizedBox(height: 1),
  //                   Text('PCX 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  //                   SizedBox(height: 2),
  //                   Text('KH 2123 WG', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
  //                   SizedBox(height: 4),
  //                   Text('Rp150.000/Day', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               width: 32,
  //               height: 32,
  //               decoration: BoxDecoration(
  //                 color: Colors.blue,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMotorcycleList() {
    return ListView.builder(
      itemCount: controller.filteredMotorcycles.length,
      itemBuilder: (context, index) {
        final motorcycle = controller.filteredMotorcycles[index];
        return _buildMotorcycleCard(motorcycle);
      },
    );
  }

  Widget _buildMotorcycleCard(Motorcycle motorcycle) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      motorcycle.brand,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Text(
                      motorcycle.model,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 2),
                    Text(
                      motorcycle.licensePlate,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp${motorcycle.price.toStringAsFixed(0)}/Day',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.chevron_right, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => Get.to(() => AddMotorcycleScreen()),
        child: Text(
          'Add New Motorcycle',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}