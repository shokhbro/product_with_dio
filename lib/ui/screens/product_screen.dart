import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_with_dio/blocs/products/products_bloc.dart';
import 'package:product_with_dio/data/models/product.dart';
import 'package:product_with_dio/ui/widgets/products_controller_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Product Screen",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductState) {
            return Center(
              child: Text(state.message),
            );
          }

          List<Product> products = [];

          if (state is LoadedProductState) {
            products = state.products;
          }

          return products.isEmpty
              ? const Center(
                  child: Text("Mahsulotlar mavjud emas!"),
                )
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(product.images[0]),
                      ),
                      title: Text(product.title),
                      subtitle: Text(product.price.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              ProductsControllerWidget.updateProduct(
                                  context, product);
                              setState(() {});
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              ProductsControllerWidget.deleteProduct(
                                  context, product);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProductsControllerWidget.addProduct(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
