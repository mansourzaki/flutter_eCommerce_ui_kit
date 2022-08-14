import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ecommerce_ui_kit/home/home.dart';
import 'package:flutter_ecommerce_ui_kit/models/category.dart';
import 'package:flutter_ecommerce_ui_kit/providers/auth_provider.dart';
import 'package:flutter_ecommerce_ui_kit/providers/firestore_provider.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/all_categories.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key? key, required this.isEditing, this.category})
      : super(key: key);
  final bool isEditing;
  final Category? category;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String? url;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    if (widget.category != null) {
      controller.text = widget.category!.name;
      url = widget.category!.imageUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isEditing ? 'Edit Category' : 'Add category')),
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
                controller: controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (widget.isEditing) {
                    await Provider.of<FireStoreProvider>(context, listen: false)
                        .updateCategory(Category(
                            id: widget.category!.id,
                            name: controller.text,
                            imageUrl: url!));
                    AppRouter.NavigateWithReplacemtnToWidget(
                        AllCategoriesScreen());
                        //Navigator.of(context).pop();
                  } else {
                    await Provider.of<FireStoreProvider>(context, listen: false)
                        .addCategory(
                            Category(name: controller.text, imageUrl: url!));
                    AppRouter.NavigateWithReplacemtnToWidget(Home());
                  }
                },
                child:
                    Text(widget.isEditing ? 'Edit Category' : 'Add Category')),
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
