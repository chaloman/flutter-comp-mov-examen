import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card_widget.dart';


class ListProductScreen extends StatelessWidget {

  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            productService.selectedProduct = productService.products[index].copy();
            Navigator.pushNamed(context, 'products/create-or-update');
          },
          child: ProductCard(product: productService.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.selectedProduct = ProductList(
              productId: 0,
              productName: '',
              productPrice: 0,
              productImage: '',
              productState: '');
          Navigator.pushNamed(context, 'products/create-or-update');
        },
      ),
    );
  }
}