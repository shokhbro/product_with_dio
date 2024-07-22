import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_with_dio/blocs/products/products_bloc.dart';
import 'package:product_with_dio/data/models/category.dart';
import 'package:product_with_dio/data/models/product.dart';

class ProductsControllerWidget {
  static Future<void> addProduct(BuildContext context) async {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final price = int.tryParse(priceController.text) ?? 0;
                final description = descriptionController.text;
                final image = imageController.text;

                final newProduct = Product(
                  id: 0,
                  title: title,
                  price: price,
                  description: description,
                  images: [image],
                  category: Category(
                    id: 0,
                    name: 'Unknown',
                    image: '',
                  ),
                );
                context.read<ProductsBloc>().add(AddProductsEvent(newProduct));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> updateProduct(
      BuildContext context, Product product) async {
    final titleController = TextEditingController(text: product.title);
    final priceController =
        TextEditingController(text: product.price.toString());
    final descriptionController =
        TextEditingController(text: product.description);
    final imageController = TextEditingController(text: product.images[0]);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final price = int.tryParse(priceController.text) ?? 0;
                final description = descriptionController.text;
                final image = imageController.text;

                final updatedProduct = Product(
                  id: product.id,
                  title: title,
                  price: price,
                  description: description,
                  images: [image],
                  category: product.category,
                );
                context
                    .read<ProductsBloc>()
                    .add(EditProductsEvent(product.id, updatedProduct));
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> deleteProduct(
    BuildContext context,
    Product product,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Product"),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cencel"),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ProductsBloc>()
                    .add(DeleteProductsEvent(product.id));
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
