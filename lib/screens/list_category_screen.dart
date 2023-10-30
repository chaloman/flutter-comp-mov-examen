import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../services/category_service.dart';
import '../widgets/category_list_item_widget.dart';
import 'loading_screen.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            categoryService.selectedCategory = categoryService.categories[index].copy();
            Navigator.pushNamed(context, 'categories/create-or-update');
          },
          child: CategoryListItem(category: categoryService.categories[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear Categoria",
        onPressed: () {
          categoryService.selectedCategory = CategoryList(categoryId: 0, categoryName: '', categoryState: '');
          Navigator.pushNamed(context, 'categories/create-or-update');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}