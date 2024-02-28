part of 'product_bloc.dart';

class ProductState {
  bool loading;
  ProductState({required this.loading});
}

class ProductInitial extends ProductState {
  ProductInitial() : super(loading: false);
}
