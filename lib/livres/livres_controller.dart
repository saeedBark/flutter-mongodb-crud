import 'package:contacts_app/widget/item_model.dart';
import 'package:contacts_app/livres/livres_service.dart';
import 'package:flutter/material.dart';

class LivresController extends ChangeNotifier {
  final LivresService _service = LivresService();
  List<Item> allItems = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool isLoading = false;

  LivresController() {
    getLivres();
  }

  Future<void> getLivre(String id) async {
    isLoading = true;
    final item = await _service.getLivre(id);

    nameController.text = item['name'];
    descriptionController.text = item['description'];
    quantityController.text = item['qty'].toString();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getLivres() async {
    isLoading = true;
    final items = await _service.getItems();
    allItems = items
        .map((product) => Item(
              id: product['_id'],
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

      await getLivres();
      isLoading = false;
      notifyListeners();
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateItem(
      String id, BuildContext context, LivresController cont) async {
    try {
      await _service.updateItem(nameController.text, descriptionController.text,
          int.tryParse(quantityController.text) ?? 0);
      await getLivres().then((value) => Navigator.pop(context));
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
