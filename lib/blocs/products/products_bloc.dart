import 'package:product_with_dio/data/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_with_dio/data/repositories/product_repository.dart';

part 'products_state.dart';
part 'products_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductsBloc({required ProductRepository productRepositor})
      : _productRepository = productRepositor,
        super(InitialProductState()) {
    on<GetProductsEvent>(_getProduct);
    on<AddProductsEvent>(_addProduct);
    on<EditProductsEvent>(_editProduct);
    on<DeleteProductsEvent>(_deleteProduct);

  }

  void _getProduct(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingProductState());
    try {
      final response = await _productRepository.getProduct();
      emit(LoadedProductState(response));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void _addProduct(
    AddProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingProductState());
    try {
      await _productRepository.addProduct(event.product);
      final products = await _productRepository.getProduct();
      emit(LoadedProductState(products));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void _editProduct(
    EditProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingProductState());
    try {
      await _productRepository.updateProduct(event.id, event.product);
      final products = await _productRepository.getProduct();
      emit(LoadedProductState(products));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

    void _deleteProduct(
    DeleteProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingProductState());
    try {
      await _productRepository.deleteProduct(event.id);
      final products = await _productRepository.getProduct();
      emit(LoadedProductState(products));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }
}
