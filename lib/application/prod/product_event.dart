part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

// ignore: must_be_immutable
class AddProdEvent extends ProductEvent {
  AddProdEvent(
      {required this.prodName, required this.measureMent, required this.price});
  String prodName;
  String measureMent;
  String price;
}

class SearchProd extends ProductEvent {}
// ignore: must_be_immutable

