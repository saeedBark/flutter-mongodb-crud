import 'package:contacts_app/widget/item_model.dart';
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
    getLaboratories();
  }

  Future<void> getLaboratory(String id) async {
    isLoading = true;
    final item = await _service.getLaboratory(id);

    nameController.text = item['name'];
    descriptionController.text = item['description'];
    quantityController.text = item['qty'].toString();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getLaboratories() async {
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

      await _service.addItem(
        nameController.text,
        descriptionController.text,
        int.tryParse(quantityController.text) ?? 0,
      );

      nameController.clear();
      descriptionController.clear();
      quantityController.clear();

      // Close the dialog box

      await getLaboratories();
      isLoading = false;
      notifyListeners();
      const SnackBar(
        content: Text('Laboratory added successfully'),
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateItem(
    String id,
    BuildContext context,
  ) async {
    try {
      await _service.updateItem(nameController.text, descriptionController.text,
          int.tryParse(quantityController.text) ?? 0);
      await getLaboratories().then((value) => Navigator.pop(context));
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _service.deleteProduct(id);
      allItems.removeWhere((item) => item.name == id);

      const SnackBar(
        content: Text('Laboratory deleted successfully'),
        backgroundColor: Colors.amber,
      );

      notifyListeners();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}
