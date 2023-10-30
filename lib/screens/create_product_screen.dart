import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_form_provider.dart';
import '../services/product_service.dart';
import '../ui/inputs_decoration.dart';
import '../widgets/product_image_widget.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductScreenBody(
        productService: productService,
      )
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.selectedProduct!.productImage,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.remove_circle),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.product, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.product);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    bool switchValue = product.productState == "Activo";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'Nombre obligatorio';
                  }
                },
                decoration: InputColors.authInputDecoration(
                  hinText: 'Nombre Producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputColors.authInputDecoration(
                  hinText: '---',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: switchValue,
                onChanged: (value) {
                  product.productState = value == true ? 'Activo': 'Bloqueado';
                  switchValue = value;
                },
                activeColor: Colors.blue,
                title: const Text('Disponible'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 5),
          blurRadius: 10,
        )
      ]);
}