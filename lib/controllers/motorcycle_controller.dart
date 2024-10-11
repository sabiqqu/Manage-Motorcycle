import 'package:get/get.dart';
import '../models/motorcycle.dart';
//import 'package:flutter/material.dart';

class MotorcycleController extends GetxController {
  final RxList<Motorcycle> _motorcycles = <Motorcycle>[].obs;
  final RxList<Motorcycle> _filteredMotorcycles = <Motorcycle>[].obs;

  List<Motorcycle> get motorcycles => _motorcycles;
  List<Motorcycle> get filteredMotorcycles => _filteredMotorcycles;

  @override
  void onInit() {
    super.onInit();
    _filteredMotorcycles.assignAll(_motorcycles);
  }

  void addMotorcycle(Motorcycle motorcycle) {
    _motorcycles.add(motorcycle);
    _filteredMotorcycles.add(motorcycle);
    update();
  }

  void deleteMotorcycle(Motorcycle motorcycle) {
    _motorcycles.remove(motorcycle);
    _filteredMotorcycles.remove(motorcycle);
    update();
  }

  void updateMotorcycle(Motorcycle oldMotorcycle, Motorcycle updatedMotorcycle) {
    final index = _motorcycles.indexWhere((m) => m.licensePlate == oldMotorcycle.licensePlate);
    if (index != -1) {
      _motorcycles[index] = updatedMotorcycle;
      final filteredIndex = _filteredMotorcycles.indexWhere((m) => m.licensePlate == oldMotorcycle.licensePlate);
      if (filteredIndex != -1) {
        _filteredMotorcycles[filteredIndex] = updatedMotorcycle;
      }
      update();
    }
  }

  void searchMotorcycles(String query) {
    if (query.isEmpty) {
      _filteredMotorcycles.assignAll(_motorcycles);
    } else {
      _filteredMotorcycles.assignAll(_motorcycles.where((motorcycle) =>
          motorcycle.brand.toLowerCase().contains(query.toLowerCase()) ||
          motorcycle.model.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void filterMotorcycles(String brand) {
    if (brand == 'All') {
      _filteredMotorcycles.assignAll(_motorcycles);
    } else {
      _filteredMotorcycles.assignAll(_motorcycles.where((motorcycle) =>
          motorcycle.brand == brand));
    }
  }
}
