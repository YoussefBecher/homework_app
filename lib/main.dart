import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youssef',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class CarItem {
  final String image;
  final String marque;
  final String description;
  const CarItem(this.image, this.marque, this.description);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CarItem> cars = const [
    CarItem('assets/images/BMW.jpg', 'BMW',
        'BMW Série 3 : berline sportive bleue, élégante et dynamique.'),
    CarItem('assets/images/bogati.jpg', 'Bugatti',
        'Bugatti Chiron : hypercar noire, l\'une des plus rapides au monde.'),
    CarItem('assets/images/clio 6.jpg', 'Renault',
        'Renault Clio 6 : citadine bleue, moderne et économique.'),
    CarItem('assets/images/mercedes.jpg', 'Mercedes-AMG',
        'Mercedes-AMG GT : coupé sport gris argent, puissant et luxueux.'),
    CarItem('assets/images/rolls royce.jpg', 'Rolls-Royce',
        'Rolls-Royce Cullinan : SUV de luxe noir, confort et prestige.'),
    CarItem('assets/images/tesla.jpg', 'Tesla',
        'Tesla : voiture électrique futuriste au design innovant.'),
  ];

  int index = 0;

  void changer() {
    setState(() {
      index = (index + 1) % cars.length;
    });
  }

  // Nombre d'images (le menu reste ouvert)
  void afficherNombreImages() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nombre d\'images'),
        content: Text('Il y a ${cars.length} images.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Liste des marques : un clic affiche l'image de la voiture choisie
  void afficherMarques() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Liste des marques'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < cars.length; i++)
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(cars[i].marque,
                      style: const TextStyle(fontSize: 18)),
                  onTap: () {
                    setState(() {
                      index = i; // choisit l'image de la marque cliquée
                    });
                    Navigator.pop(dialogContext); // ferme la fenêtre
                    Navigator.pop(context); // ferme le menu
                  },
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Réinitialiser : revient à la première image et ferme le menu
  void reinitialiser() {
    setState(() {
      index = 0;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application réinitialisée')),
    );
  }

  // Quitter avec confirmation
  void quitter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter'),
        content: const Text('Voulez-vous quitter l\'application ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Quitter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = cars[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Youssef'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('mon application mobile')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Youssef',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Nombre d\'images'),
              onTap: afficherNombreImages,
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Liste des marques'),
              onTap: afficherMarques,
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Réinitialiser'),
              onTap: reinitialiser,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: quitter,
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(car.image, height: 220, fit: BoxFit.cover),
              ),
              const SizedBox(height: 24),
              Text(
                car.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: changer,
                child: const Text('Change'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}