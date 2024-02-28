import 'package:firestore_demo/application/prod/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProdScreen extends StatefulWidget {
  const AddProdScreen({super.key});

  @override
  State<AddProdScreen> createState() => _AddProdScreenState();
}

class _AddProdScreenState extends State<AddProdScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController prodnameEditingController = TextEditingController();
    TextEditingController measurementEditingController =
        TextEditingController();
    TextEditingController priceEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Prod"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputField(
                hintText: 'Prod name',
                errorMessage: 'Please enter your email',
                textEditingController: prodnameEditingController,
              ),
              const SizedBox(height: 20),
              inputField(
                hintText: 'Measurement',
                errorMessage: 'Please enter your password',
                textEditingController: measurementEditingController,
              ),
              const SizedBox(height: 10),
              inputField(
                hintText: 'Price',
                errorMessage: 'Please enter your password',
                textEditingController: priceEditingController,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.loading
                      ? const CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: () {
                            context.read<ProductBloc>().add(AddProdEvent(
                                  measureMent:
                                      measurementEditingController.text,
                                  price: priceEditingController.text,
                                  prodName: prodnameEditingController.text,
                                ));
                          },
                          label: const Text("Add prod"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputField({
  required String hintText,
  required String errorMessage,
  required TextEditingController textEditingController,
}) {
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: null,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    },
  );
}
