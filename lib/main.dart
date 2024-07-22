import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_with_dio/app.dart';
import 'package:product_with_dio/blocs/products/products_bloc.dart';
import 'package:product_with_dio/data/repositories/product_repository.dart';
import 'package:product_with_dio/data/services/dio_product_service.dart';

void main() {
  final dioProductService = DioProductService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          return ProductRepository(dioProductService: dioProductService);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return ProductsBloc(
              productRepositor: context.read<ProductRepository>(),
            );
          }),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
