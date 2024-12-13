import 'package:contacts_app/Laboratoires/laboratory_controller.dart';
import 'package:contacts_app/main.dart';
import 'package:contacts_app/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaboratoresView extends StatelessWidget {
  const LaboratoresView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LaboratroiesController>(context);
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
                    controller
                        .getLaboratory(controller.allItems[index].id)
                        .then(
                          (value) => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ItemDialog(
                                id: controller.laboratoryId,
                                nameController: controller.nameController,
                                descriptionController:
                                    controller.descriptionController,
                                quantityController:
                                    controller.quantityController,
                                onUpdate: () => controller.editLaboratory(
                                  controller.allItems[index].id,
                                  context,
                                ),
                              );
                            },
                          ),
                        );
                  },
                  onRemove: () {
                    controller.deleteLaboratory(
                      controller.allItems[index].id,
                      context,
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ItemDialog(
                onCreate: () => controller.addLaboratory(context),
                nameController: controller.nameController,
                descriptionController: controller.descriptionController,
                quantityController: controller.quantityController,
              );
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
