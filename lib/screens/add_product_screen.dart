import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ecommerce_ui_kit/home/home.dart';
import 'package:flutter_ecommerce_ui_kit/models/category.dart';
import 'package:flutter_ecommerce_ui_kit/models/product.dart';
import 'package:flutter_ecommerce_ui_kit/providers/auth_provider.dart';
import 'package:flutter_ecommerce_ui_kit/providers/firestore_provider.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/all_categories.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key, required this.category}) : super(key: key);
  final Category? category;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? url;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                color: Colors.grey[400],
                width: double.infinity,
                child: url == null
                    ? isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                            child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              isLoading = true;
                              setState(() {});
                              url = await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .uploadImage();
                              isLoading = false;
                              setState(() {});
                            },
                          ))
                    : CachedNetworkImage(
                        imageUrl: url!,
                        fit: BoxFit.cover,
                      )),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Product name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: descController,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Qty',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Product prod = Product(
                      name: nameController.text,
                      description: descController.text,
                      price: num.parse(priceController.text),
                      image: url!,
                      quantity: int.parse(priceController.text));
                  await Provider.of<FireStoreProvider>(context, listen: false)
                      .addProduct(prod, widget.category!.id!);
                  // AppRouter.NavigateWithReplacemtnToWidget(
                  //     AllCategoriesScreen());
                },
                child: Text('Add Product')),
            ElevatedButton(
                onPressed: () {
                  url = null;
                  setState(() {});
                },
                child: Text('Remove image')),
          ],
        ),
      ),
    );
  }
}
