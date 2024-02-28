import 'package:firestore_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String measurement;
  final String price;
  final String id;

  const ProductDetailScreen(
      {super.key,
      required this.productName,
      required this.measurement,
      required this.price,
      required this.id});

  @override
  Widget build(BuildContext context) {
    // Encode product details into a string
    final String qrData =
        '{"name": "$productName", "measurement": "$measurement", "price": $price , "id" : $id}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Center(
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              title: "id : $id",
            ),
            CustomButton(
              title: "Name : $productName",
            ),
            CustomButton(
              title: "measurement : $measurement",
            ),
            CustomButton(
              title: "price : $productName",
            ),
          ],
        ),
      ),
    );
  }
}
