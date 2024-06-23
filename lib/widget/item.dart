import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String description;
  final int quantity;
  final Function onUpdate;
  final Function onRemove;

  const ItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onUpdate(),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => onRemove(),
            ),
          ],
        ),
      ),
    );
  }
}
