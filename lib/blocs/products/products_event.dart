part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {}

final class AddProductsEvent extends ProductsEvent {
  final Product product;
  AddProductsEvent(this.product);
}

final class EditProductsEvent extends ProductsEvent {
  final int id;
  final Product product;

  EditProductsEvent(this.id, this.product);
}

final class DeleteProductsEvent extends ProductsEvent {
  final int id;
  DeleteProductsEvent(this.id);
}
