import 'package:contacts_app/widget/item_model.dart';
import 'package:contacts_app/Laboratoires/laboratory_service.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LaboratroiesController extends ChangeNotifier {
  final LaboratoriesService _service = LaboratoriesService();
  List<Item> allItems = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  ObjectId laboratoryId = ObjectId();

  bool isLoading = false;

  LaboratroiesController() {
    getLaboratories();
  }

  Future<void> getLaboratory(ObjectId id) async {
    isLoading = true;
    final item = await _service.getLaboratory(id);
    laboratoryId = item['_id'];
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

  Future<void> addLaboratory(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.addLaboratroy(
        nameController.text,
        descriptionController.text,
        int.tryParse(quantityController.text) ?? 0,
      );

      nameController.clear();
      descriptionController.clear();
      quantityController.clear();

      await getLaboratories();
      isLoading = false;

      Navigator.of(context).pop();
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> editLaboratory(
    ObjectId id,
    BuildContext context,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.editLaboratory(
        laboratoryId,
        nameController.text,
        descriptionController.text,
        int.tryParse(quantityController.text) ?? 0,
      );
      await getLaboratories().then((value) {
        isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      });
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  Future<void> deleteLaboratory(ObjectId id, BuildContext context) async {
    try {
      await _service.deleteLabroatory(id);
      allItems.removeWhere((item) => item.id == id);

      await getLaboratories().then((value) {
        notifyListeners();
      });
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}
