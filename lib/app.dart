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
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final title = titles[index].entries;
          return CardWidget(
            title: title.single.key,
            icon: title.single.value,
            image: images[index],
            onTap: () {
              if (title.single.key == 'Laboratories') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaboratoresView(),
                  ),
                );
              } else if (title.single.key == 'Livres') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LivresView(),
                  ),
                );
              } else {
                // Handle other navigation
              }
            },
          );
        },
      ),
    );
  }
}

class CustomMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomMenuButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.menu, color: Colors.white),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final String image;
  final void Function()? onTap;
  const CardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                image,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, Icon>> titles = [
  {'Laboratories': const Icon(Icons.science)},
  {'Livres': const Icon(Icons.book)},
  {'Pharmacy': const Icon(Icons.local_pharmacy)},
  {'Documents': const Icon(Icons.build)},
  {'Equipment': const Icon(Icons.devices)},
];

List<String> images = [
  'https://images.unsplash.com/photo-1582719471384-894fbb16e074?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGxhYm9yYXRvcnl8ZW58MHx8MHx8fDA%3D',
  'https://plus.unsplash.com/premium_photo-1677567996070-68fa4181775a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGJvb2tzfGVufDB8fDB8fHww',
  'https://images.unsplash.com/photo-1576602976047-174e57a47881?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8UGhhcm1hY3l8ZW58MHx8MHx8fDA%3D',
  'https://images.unsplash.com/photo-1544396821-4dd40b938ad3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGRvY3VtZW50c3xlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1556379118-7034d926d258?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SW5zdHJ1bWVudHN8ZW58MHx8MHx8fDA%3D',
];
