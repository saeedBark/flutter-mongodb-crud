import 'package:contacts_app/item_controller.dart';
import 'package:contacts_app/main.dart';
import 'package:contacts_app/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ItemController>(context);
    return Scaffold(
      body: controller.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.allItems.length,
              itemBuilder: (context, index) => ItemCard(
                  name: controller.allItems[index].name,
                  description: controller.allItems[index].details,
                  quantity: controller.allItems[index].qty,
                  
                  onUpdate: ()  {
                     

                   
                  },
                  onRemove: () {
                    controller.deleteItem(controller.allItems[index].name);
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddItemDialog(controller: controller);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
