import 'package:contacts_app/Laboratoires/laboratory_controller.dart';
import 'package:contacts_app/app.dart';
import 'package:contacts_app/livres/livres_controller.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyAppStock());
}

class MyAppStock extends StatelessWidget {
  const MyAppStock({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LaboratroiesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LivresController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GestionStock(),
      ),
    );
  }
}

class ItemDialog extends StatelessWidget {
  final ObjectId? id;
  final TextEditingController? nameController,
      descriptionController,
      quantityController;

  final void Function()? onUpdate;
  final void Function()? onCreate;

  const ItemDialog({
    super.key,
    this.id,
    this.nameController,
    this.descriptionController,
    this.quantityController,
    this.onUpdate,
    this.onCreate,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: id == null ? const Text('Add New Item') : const Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog box
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: id == null ? onCreate : onUpdate,
          child: id == null ? const Text('Add') : const Text('Edit'),
        ),
      ],
    );
  }
}
