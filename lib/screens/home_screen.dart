import 'package:flutter/material.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Listado Módulos')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const [
            CardWidget(
              backgroundColor: Colors.orange,
              icon: Icons.shopping_bag,
              text: 'Productos',
              route: 'products',
            ),
            CardWidget(
              backgroundColor: Colors.orange,
              icon: Icons.delivery_dining,
              text: 'Proveedores',
              route: 'providers'),
            CardWidget(
              backgroundColor: Colors.orange,
              icon: Icons.label_important,
              text: 'Categorias',
              route: 'categories',
            )
          ],
        )
      ),
    );
  }
}