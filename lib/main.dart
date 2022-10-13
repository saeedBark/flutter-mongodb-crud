import 'package:contacts_app/app.dart';
import 'package:contacts_app/item_controller.dart';
import 'package:contacts_app/item_view_page.dart';
import 'package:contacts_app/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ItemListView()),
    );
  }
}

class _ItemBody extends StatelessWidget {
  const _ItemBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ItemController>(context);
    return MaterialApp(
      title: 'Inventory Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Column(
            children: [
              ListView.builder(
                itemCount: controller.allItems.length,
                itemBuilder: (context, index) => ItemCard(
                    name: controller.allItems[index].name,
                    description: controller.allItems[index].details,
                    quantity: controller.allItems[index].qty,
                    onUpdate: () {
                      // Handle update action
                    },
                    onRemove: () {
                      controller.deleteItem(controller.allItems[index].name);
                    },
            
                ),
              ),
            IconButton(onPressed:() {
              showDialog(
                context: context,
                builder: (context) => AddItemDialog(
                  controller: controller,
                ),
              );
            }, icon: const Icon(Icons.add),) ,           ],
          ),
         
          ),
          
    );
  }
}

class AddItemDialog extends StatelessWidget {
  final ItemController controller;
  const AddItemDialog({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: controller.quantityController,
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
          onPressed: () {
            controller.addProduct(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
