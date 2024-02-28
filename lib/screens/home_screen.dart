import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_demo/screens/add_prod_screen.dart';
import 'package:firestore_demo/screens/login_screen.dart';
import 'package:firestore_demo/screens/prod_details_screen.dart';
import 'package:firestore_demo/screens/quick_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  late Stream<QuerySnapshot> _productStream;

  getPermission() async {
    await Permission.camera.request();
  }

  @override
  void initState() {
    getPermission();
    _productStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   PinHelperClass().showAlertDialogue();
    // });
    super.initState();
  }

  void _searchProducts(String query) {
    setState(() {
      _productStream = FirebaseFirestore.instance
          .collection('products')
          .where('prodname', isGreaterThanOrEqualTo: query)
          .where('prodname', isLessThan: '$query\uf8ff')
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              try {
                getPermission();
                String cameraScanResult = await scanner.scan() ?? "";
                log("jsonnn $cameraScanResult");
                Fluttertoast.showToast(
                    msg: "camer result productData  $cameraScanResult");

                Map<String, dynamic> productMap = jsonDecode(cameraScanResult);

                // Extract the desired fields
                String name = productMap['name'].toString();
                String measurement = productMap['measurement'].toString();
                String price = productMap['price'].toString();
                // String id = productMap['id'];
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    productName: name,
                    measurement: measurement,
                    price: price,
                  ),
                ));
                // Print the extracted values
                log('Name: $name');
                log('Measurement: $measurement');
                log('Price: $price');
                // log('ID: $id');
              } catch (e) {
                log("error occure $e");
              }
            },
            child: const Icon(Icons.qr_code_scanner),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProdScreen()));
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      appBar: AppBar(
        actions: const [],
        title: const Text("WELCOME HOME :)"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (va) {
                if (va.isEmpty) {
                  setState(() {
                    _productStream = FirebaseFirestore.instance
                        .collection('products')
                        .snapshots();
                  });
                } else {
                  _searchProducts(va);
                }
              },
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Search",
                suffixIcon: null,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _productStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                        measurement: data['measurement'],
                                        price: data['price'],
                                        productName: data['prodname'],
                                      )));
                        },
                        title: Text(data['prodname']),
                        subtitle: Text(
                            'Measurement: ${data['measurement']}, Price: ${data['price']}'),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
  });
  final String title;
  // final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              color: Colors.purple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(title.toLowerCase().contains("add")
                  //     ? Icons.add
                  //     : Icons.remove_red_eye_sharp),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
