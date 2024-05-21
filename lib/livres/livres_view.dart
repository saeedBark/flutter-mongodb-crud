import 'package:contacts_app/livres/livres_controller.dart';
import 'package:contacts_app/main.dart';
import 'package:contacts_app/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LivresView extends StatelessWidget {
  const LivresView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LivresController>(context);
    return Scaffold(
      appBar: AppBar(),
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
                  onUpdate: () {
                    controller.getItem(controller.allItems[index].name).then(
                          (value) => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddItemDialog();
                            },
                          ),
                        );
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
              return AddItemDialog();
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
