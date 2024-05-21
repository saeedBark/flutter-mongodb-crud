import 'package:contacts_app/Laboratoires/laboratory_view.dart';
import 'package:contacts_app/livres/livres_view.dart';
import 'package:flutter/material.dart';

class GestionStock extends StatelessWidget {
  const GestionStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final title = titles[index].entries;
          return CardWidget(
            title: title.single.key,
            icon: title.single.value,
            onTap: () {
              if (title.single.key == 'Laboratories') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaboratoresView(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LivresView(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function()? onTap;
  const CardWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shadowColor: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, Icon>> titles = [
  {'Laboratories': const Icon(Icons.add)},
  {'Livres': const Icon(Icons.remove)},
];
