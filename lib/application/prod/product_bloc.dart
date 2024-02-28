import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_demo/screens/home_screen.dart';
import 'package:firestore_demo/services/route_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      if (event is AddProdEvent) {
        emit(ProductState(loading: true));
        final collection = FirebaseFirestore.instance.collection("products");
        String id = collection.doc().id;

        final newProd = ProductModel(
                id: id,
                prodName: event.prodName,
                price: event.price,
                measurement: event.measureMent)
            .toJson();

        try {
          collection.doc(id).set(newProd);
          Fluttertoast.showToast(msg: "Product Added");
          Navigator.push(RouteState.currentContext,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } catch (e) {
          Fluttertoast.showToast(msg: "Failed to add product: $e");
        }

        emit(ProductState(loading: false));
      }
    });
  }
}

class ProductModel {
  final String? prodName;
  final String? measurement;
  final String? price;
  final String? id;
  ProductModel({this.prodName, this.measurement, this.price, this.id});

  static ProductModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ProductModel(
        prodName: snapshot["prodname"],
        measurement: snapshot["measurement"],
        price: snapshot["price"],
        id: snapshot["id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "prodname": prodName,
      "measurement": measurement,
      "price": price,
      "id": id,
    };
  }
}
