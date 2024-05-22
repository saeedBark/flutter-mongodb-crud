import 'package:contacts_app/Laboratoires/laboratory_controller.dart';
import 'package:contacts_app/app.dart';
import 'package:contacts_app/livres/livres_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyAppStock());
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

class AddItemDialog extends StatelessWidget {
  final TextEditingController? nameController,
      descriptionController,
      quantityController;

  final void Function()? onUpdate;
  final void Function()? onCreate;

  const AddItemDialog({
    super.key,
    this.nameController,
    this.descriptionController,
    this.quantityController,
    this.onUpdate,
    this.onCreate,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Item'),
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
          onPressed: onCreate,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
