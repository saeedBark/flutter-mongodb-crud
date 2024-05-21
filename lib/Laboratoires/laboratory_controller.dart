import 'package:contacts_app/item_model.dart';
import 'package:contacts_app/Laboratoires/laboratory_service.dart';
import 'package:flutter/material.dart';

class LaboratroiesController extends ChangeNotifier {
  final LaboratoriesService _service = LaboratoriesService();
  List<Item> allItems = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool isLoading = false;

  LaboratroiesController() {
    getItems();
  }

  Future<void> getItem(String id) async {
    isLoading = true;
    final item = await _service.getItem(id);

    nameController.text = item['name'];
    descriptionController.text = item['description'];
    quantityController.text = item['qty'].toString();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getItems() async {
    isLoading = true;
    final items = await _service.getItems();
    allItems = items
        .map((product) => Item(
              id: product['_id'].toString(),
              name: product['name'],
              details: product['description'],
              qty: product['qty'],
            ))
        .toList();
    isLoading = false;
    print('connect success');
    notifyListeners();
  }

  Future<void> addProduct(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      Navigator.of(context).pop();

      await _service.addItem(
        nameController.text,
        descriptionController.text,
        int.tryParse(quantityController.text) ?? 0,
      );

      nameController.clear();
      descriptionController.clear();
      quantityController.clear();

      // Close the dialog box

      await getItems();
      isLoading = false;
      notifyListeners();
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateItem(
      String id, BuildContext context, LaboratroiesController cont) async {
    try {
      await _service.updateItem(nameController.text, descriptionController.text,
          int.tryParse(quantityController.text) ?? 0);
      await getItems().then((value) => Navigator.pop(context));
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _service.deleteProduct(id);
      allItems.removeWhere((item) => item.id == id);

      notifyListeners();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}
